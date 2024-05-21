Return-Path: <linux-kernel+bounces-185160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB98CB15D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7621F229B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5A1448DA;
	Tue, 21 May 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5MoUKjs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA47352B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305331; cv=none; b=JQKULzsJs7hwG6et2K3wXF2VXi9Rmn1U47Uh/Fr8/Jc0xZXSbO3+xbPE0BdtdNri5jyU18w3g2L3YBieJH3Ee3xkv4JNpLV4W42adpJnX7cYe/lDunHKuor+5322wGN0u8skrj47oG+xX0Oir7iW38xstk0lYuVeCmEXDHwEZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305331; c=relaxed/simple;
	bh=QdvNN4ux3vftozDxbS9yFQvNqh/YWSRTOOgZELawYjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCYARQS5EnWNuK9+q+8pMSmjxpvcbZNtFRragzANh17UbYMahiMGiPcdXNv3b8dQ6bvgHyxelDvJ5R4j8/43pC+44WFLGYH4z6bPTSdTASOjgTe/zgxnEhMmNJALtdVzHsa8vlDFU7Fv+mdCSP3gxTRxjhNV2XJHGg3g5diFPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5MoUKjs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716305328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvalVcpeJBX7T4B/fcPMOd0QFgC1iXDiyKWmYajeijk=;
	b=M5MoUKjsUZaorPK5vXzjwBbgCpUWysY1tzkX7YQJ5uh7TfpdQRBrxQhcg72p1czaxNTczP
	ICj6pmfDYoLRgN3tcwlQwianiVNw3D4KChkfIoyyjRPhmFhMb3XTrseg207LcwDugRMMO6
	rGGS9jIYDuFnB9Kl7bD7zsY1LeIt2TE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-gSOKllg9MtGHyYYp3Xi57w-1; Tue, 21 May 2024 11:28:47 -0400
X-MC-Unique: gSOKllg9MtGHyYYp3Xi57w-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1eec5aba2bdso113127745ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305326; x=1716910126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvalVcpeJBX7T4B/fcPMOd0QFgC1iXDiyKWmYajeijk=;
        b=AlckR1tOnpIcS+fLt7mE9ODiTlA/LxDqrinkNx4bNRQCDonnEzF+pw7zlFm+LNCQPA
         S3s6F5ykAiHceh1yRidalTE8MD160L1LCRcAN7o2h5RDIHId9iHa8uQffKodAQ37pTIu
         aaaeCZcnG++4MX5l2aNXKIgZNueLz49VgQzWlX3sGidSD6xvzDBRt/U5B1GoNA2HrzrV
         EjZvSOguU+FmoxHsmSwqoRHX58tQg8yuMg3pOhJGbIapPpKQQCADNG2L0pGEHPF9g5RD
         5i0k04k//FQA2xyU9huIxHkVFOzbqgwy1peg+t2EpcfbGXszNlysjhYsaDtDsgjJSW+f
         bR2w==
X-Forwarded-Encrypted: i=1; AJvYcCU7Q8sOpzirenvAZxko7uPxBydff3jRl8iBLpfwv7o1tQvEonY8pSy3jFNCcbIff7ohVjI7JRm8uu5DCXy0T6DqzG0qlTj9au04C+zM
X-Gm-Message-State: AOJu0Yw6zdCNup6VY4i6hFgrxfZ5nMENVxtYutfaJ7HA4Qbyfp5VWTw8
	qixTUQsS2UivXibRJz2b4Etrzq+8yqNNaYgMB0gCBdTcT0T1SOgjAODJ20d51MXKw81/ndUlx/G
	lnLMG3jR+4F4I+/R2N+OeqQ9ei3WoJgByM6/EDNafPvVQqHDBonOF/Q2gQgRjwQ==
X-Received: by 2002:a17:902:bcc4:b0:1ee:c491:ab62 with SMTP id d9443c01a7336-1ef43d2ea47mr294190365ad.25.1716305326128;
        Tue, 21 May 2024 08:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx1n4JLjA52CrbGijWG8t6of/hs9QNgynVg+bR4Tq3GlBgh09Hyleep4PO0WPhhy+YxSgScg==
X-Received: by 2002:a17:902:bcc4:b0:1ee:c491:ab62 with SMTP id d9443c01a7336-1ef43d2ea47mr294189915ad.25.1716305325600;
        Tue, 21 May 2024 08:28:45 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2ff0b9027sm39741685ad.94.2024.05.21.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:28:44 -0700 (PDT)
Date: Wed, 22 May 2024 00:28:41 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, syoshida@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
Message-ID: <Zky9qU3QKziLAQDN@zeus>
References: <20240517020609.476882-1-ryasuoka@redhat.com>
 <8947cb3f-39b5-4483-af1d-82d3fa4bb7ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8947cb3f-39b5-4483-af1d-82d3fa4bb7ad@kernel.org>

On Mon, May 20, 2024 at 11:58:47AM +0200, Krzysztof Kozlowski wrote:
> On 17/05/2024 04:06, Ryosuke Yasuoka wrote:
> > When nci_rx_work() receives a zero-length payload packet, it should not
> > discard the packet and exit the loop. Instead, it should continue
> > processing subsequent packets.
> > 
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> 
> That's not a valid tag here. Every bug we find - like hundreds of my
> commits - is reported by us...
> 
> Drop the tag.
> 
> Best regards,
> Krzysztof

Thank you for pointing me out, Krzysztof. I didn't understand how to use
Reported-by tag correctly. Now I'm clear.
Yes, I remove the tag and send a new patch.

Very sorry for sending this patch again and again.

Ryosuke


