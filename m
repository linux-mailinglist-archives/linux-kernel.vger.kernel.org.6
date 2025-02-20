Return-Path: <linux-kernel+bounces-524901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43482A3E88A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284BD17646F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01783265633;
	Thu, 20 Feb 2025 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpG9No5o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF871EE006
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094354; cv=none; b=INpxQEM+EptzBCdrADo4PcygMWthDM1i8mhJWl13scgpdBaIwokFPk+jqnG/9E1C/KtsXpFaoRaA1Puq0twBFr3b1Y0wGH+ep7+u08Q3/5WwoCuCfPL4YzQH4Gd7EUtKvqgK9FSwLe4pDkAp3B+wtikBPaxCu1glNLbeIj0h8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094354; c=relaxed/simple;
	bh=WyCQCkZgWtLPS2+4mp3qa+r9YKNbKr4P4U6wtDXmDbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kymh0aG4nldE33LyWHcyOZY6UnVBrgHQtXNSNX1oEnS1nryakp8yo0WSrFqKRfl7n48qypz8+BbyE8vJeTW2pdQnKAYyiUvqcCYO3UeU/inGJEYOdWFoefiAaHC+K79kyH6mjPAzt/4KngTOQyuwM4Wr4NODmtxV74B3lIxL/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpG9No5o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740094351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpXtuTJBxLIXGcIlZvfZ/VOXa5GYRIQZ7uAJoU84fS8=;
	b=UpG9No5oiqLP1vY+tpIA3FfU763HEQkjYyqgvw34YstHEd87XAs73S/rA39wAPTcL+2YSR
	z4u8jkAdbc+sgEbmSvRnIUx3Q0jumQaauUyyABZSeFu/GAAhuuN7p/G//H4DeP+E901KPj
	K1nJDpINWDNFc2kZ6SdzLRwza8cy+q4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-mcFlffKROAWOGeWby_K5pQ-1; Thu, 20 Feb 2025 18:32:30 -0500
X-MC-Unique: mcFlffKROAWOGeWby_K5pQ-1
X-Mimecast-MFC-AGG-ID: mcFlffKROAWOGeWby_K5pQ_1740094350
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0a89afcaaso291844385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094350; x=1740699150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpXtuTJBxLIXGcIlZvfZ/VOXa5GYRIQZ7uAJoU84fS8=;
        b=V/emxJn0bG5ksqHb9sMaimJj3sRI6QbjegiYHhnY377wB+t19f+3QZxw9c1MWu/iJD
         rPRyMRt+zLyXPjp19/Lng9t2Np0pI2SHHTPXyNVq2cjuvkkQuhZ1BjIRjHH2pm+rTVIo
         O1H7yNAa145VW9NkRjsVSKvc9ImKvC5RHY4WE3v5dM75BDnwOfiyQ4h1G/hepmYgISA/
         yGLPBSHIxXdGbcHwuDwmnhxJjHU6l40O78PxNQ7ApqdCipt7VttwUogtMYfmnsuh5Une
         z5hUjIxo16M7pdyr6brYszO5a6T40GkwWYetBLLFxu9cQm8tnUqpqGfokGcRILCkObxQ
         0Phg==
X-Forwarded-Encrypted: i=1; AJvYcCUpyQvPjH/Y+n9k7oQFCyGAf72TnkxFSLvSJ66YbnyhYAGeIfiD1OfrDqPC3MANJEqaDS/aLVxURL41QJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1WU3hIeIZwRqt1fzJYqhPuMvuGP3v1OiuVbpLOeLIu3G4iN/
	XZC6jGAGtEGdx0y3ycnBVq9U3KGCNm7LHWos60MviglkUFLl0/nXkatbFZTQlqrIwHJ3YbqaZz0
	EwrGpjQn0Q9eo5d6eMZyKtdKYoSdOPOo5urb6Sd0KV4rukhHIkQoq4IWNjzJ9jA==
X-Gm-Gg: ASbGncvohYTrJawkSIsLPSpRVvFhKw10XSq3oFASX/8RhPCXmVcOFkBaiS6sxWbPcS+
	pBJpSotz98221c98eqG9tB5hREyD0XIBVFD3p28rDsczDjJgBoafB8fbiXf1uDPmrgMIvzGFL06
	zkH6g3fQldixfApxRhS0QvMtBmwiIsKrmvhqMwKCMIzWHWK+v/rWT9O2wqZPyFN1BVHaXjl7q2x
	5vWXU+02NHdv3BMBU04sJdAucNijJiZ8jsNscbe9ChymuSAHnLUoE4JQoM=
X-Received: by 2002:a05:620a:4512:b0:7c0:a272:65a7 with SMTP id af79cd13be357-7c0cf0e2eaamr178562885a.2.1740094349718;
        Thu, 20 Feb 2025 15:32:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFRu2Dnc+2Q7aLVvcud0WLNtdkmcDWf2h64KzsKzPXi5Ef2jfC4H9CsgJUUAwL7iouzkB4kA==
X-Received: by 2002:a05:620a:4512:b0:7c0:a272:65a7 with SMTP id af79cd13be357-7c0cf0e2eaamr178560085a.2.1740094349435;
        Thu, 20 Feb 2025 15:32:29 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09d8d4fb4sm542978785a.55.2025.02.20.15.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:32:28 -0800 (PST)
Date: Thu, 20 Feb 2025 18:32:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: david@redhat.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	bgeffon@google.com, brauner@kernel.org, hughd@google.com,
	jannh@google.com, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com,
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
	surenb@google.com, v-songbaohua@oppo.com, viro@zeniv.linux.org.uk,
	willy@infradead.org, zhangpeng362@huawei.com,
	zhengtangquan@oppo.com, yuzhao@google.com, stable@vger.kernel.org
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7e7iYNvGweeGsRU@x1.local>
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220092101.71966-1-21cnbao@gmail.com>

On Thu, Feb 20, 2025 at 10:21:01PM +1300, Barry Song wrote:
> 2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）

Could you help explain what guarantees the rmap walk not happen on a
swapcache page?

I'm not familiar with this path, though at least I see damon can start a
rmap walk on PageAnon almost with no locking..  some explanations would be
appreciated.

-- 
Peter Xu


