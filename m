Return-Path: <linux-kernel+bounces-542366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FCA4C920
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7687A3A6C45
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984322DFB2;
	Mon,  3 Mar 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU+6aHpI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20349F9E6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020738; cv=none; b=rpPknLHk6nOH9h01Zd1U+Cf8L46wcciElYFuBfajsUE7dNNYhjXPSqOfGSI2sxGMGm/vmaRrQp2aDgdlSSGEiJZ5g+QEe2YDPUktNq7tfR1EWxuRzJiE0RkTYdT5O1FxHNDwKOfG73n8ERRRTRvDsEEzz2TsNKxJA404r5yamIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020738; c=relaxed/simple;
	bh=X9vuxKvJBiI5voDqnbl4lgtxLuulj8GAfFRersEJ2U8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ML9zmvBpHb2F5knyAdwQzFZp47MpV/sJ7rFO6KIdmgN9WInbfjnh8t029J7JYo9EFn5qHqIOJCVD+73FPr1hStvAuVsYmFQc5LkdDQNckTLNseamhdD3UaTrCiHr7DovJoVOkiloI3CATFKwr9TGBPhHwSLAHdDZqju2pbXagoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VU+6aHpI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741020736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9vuxKvJBiI5voDqnbl4lgtxLuulj8GAfFRersEJ2U8=;
	b=VU+6aHpIrxqqy3pMAJatFHOXSsfeKTxLdo+Y6IIstJGcSy9my9zTWWlp+365pcTodbr6Z9
	K14vVAdThzL4A3KhrMvXNaqZ1KSHD5Q0P5k6n2LRS9ftxCP6SoRFOOVmJ5iLBh07zBaZK2
	QvZdi6bfc8xqekqoUeuYY8xIokojh3s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-V0YayNyYNFylRpcs0NUeVA-1; Mon, 03 Mar 2025 11:52:15 -0500
X-MC-Unique: V0YayNyYNFylRpcs0NUeVA-1
X-Mimecast-MFC-AGG-ID: V0YayNyYNFylRpcs0NUeVA_1741020734
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-474fb9c5524so105051cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020734; x=1741625534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9vuxKvJBiI5voDqnbl4lgtxLuulj8GAfFRersEJ2U8=;
        b=OfCn0u9VddhCxqID/yqZ5wY+pAtjNnjsVAe0LKjK+7300RWcJb7dRkFYHd7Ipb9JgF
         5sdZVkYl+UqzK2lTw+2hojSPYnVSz1INfbmACb5U2isU5E4/zyyCBppdCNoeT4KG7CE3
         XUmo4epXlatnEaUy5M/tgx8tIZ/Zy4kny6hH5Q/yYU4dNchv4HXdMBMA6STm5rthSeM3
         l1ktGMBfouxHN3eDYizpq2BtFxdZUWOKQQ42e6W91sHvMQy5Ay2c/n6/neB1BLBbv7I4
         kP3e+zMvpftbxqiZHcjqUR2K8BGfjsNvHk3xRfb+NKRH2VqHOhamUfOO/CYO8hfpKflo
         9/0w==
X-Forwarded-Encrypted: i=1; AJvYcCVkW36kw6ryYzTTxhSH2+qyAxQS8P19KCvUQMZ430SgnYIa4WDS8KSkvuytihDpM0wV++cSayFcvmNdf7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1S4Oi1wXrKJZUttkP8r4HbziToB2pDl+wz//5Y9/vNgryow4
	CXxDIzGueLAfuksnbofbTRTYfWhKP8qO7jzHPgzpl/20o4us14asCYZvzymD9IbZikOiAMroeYH
	Zj7o/N6V2PIfMd1W/jh8DriHl1A82pPcv+5xP0jZ5AxWab2unOmfMaAFijNXY9w==
X-Gm-Gg: ASbGnctBkINLgrx6LGIX404VoaMQvHGQJUbLCzUQFahtzHKGovxnzkAMO+gkljK7WPx
	rrPzyOtqU3Hz/gVotwoecLSAbWFRXI7At3f5QQNOrKwcfmaacwEghf50BuH0ivutJweqWs5nTnF
	eCyeybU59VWdUlZlFaIxmNpovkxp50JGZhwWPXyVTd9j5twUaB/TTg+4N7jU9he8obEBmCyhPBC
	5Kh3OAiGGCQCWSQfWOD0bGt6Tjy8ZGR4OSFniHGORaeLSNfRa0X0PE9g7D7OoMAK2TC03iMZhFk
	IygCcYMVW+k0IlXGkSKaIEtv3R4e89qCLmi4tdvoJEbXTlhXkFHTGC15OT4=
X-Received: by 2002:ac8:7d85:0:b0:474:e4bd:240f with SMTP id d75a77b69052e-474e4bd2933mr76620491cf.15.1741020734609;
        Mon, 03 Mar 2025 08:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESSqcVQ5BVQ40j7IqzCcdGGkpDty4sSfwg8hSbBvllBwbMi0l4DwBjqREU0L+0P4dQsuTKlA==
X-Received: by 2002:ac8:7d85:0:b0:474:e4bd:240f with SMTP id d75a77b69052e-474e4bd2933mr76620091cf.15.1741020734300;
        Mon, 03 Mar 2025 08:52:14 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a11fdsm60247171cf.15.2025.03.03.08.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:52:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <efe964ad-9b14-48b9-9dab-30f29263191b@redhat.com>
Date: Mon, 3 Mar 2025 11:52:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] LOCKDEP and Rust locking changes for v6.15
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home> <Z8IHIYOnI-DMHlC8@boqun-archlinux>
Content-Language: en-US
In-Reply-To: <Z8IHIYOnI-DMHlC8@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/28/25 1:57 PM, Boqun Feng wrote:
> On Tue, Feb 25, 2025 at 08:12:03PM -0800, Boqun Feng wrote:
>> Hi Peter & Ingo,
>>
> Ping ;-)

Hi Peter, are you going to pull this lockep branch into tip?

Thanks,
Longman


