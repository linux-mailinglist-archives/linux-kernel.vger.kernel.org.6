Return-Path: <linux-kernel+bounces-561890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF551A61828
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B557A854B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202F204598;
	Fri, 14 Mar 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZudwzfoH"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866242036E0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973882; cv=none; b=anHSqdkOyDTUdU4JZL1hYYh/eEAkBc+hnN+IEFrBRfR3jI8pW/Wros0rxis7+ccKvwAio45Dq6EZzraEy4SzIKXMsaWlMeodpYD28dz75f6MAv+b5TT3dTIlCi7/EhbbbBJpyNS8yN4cCoE+AV/9ArEakmiNBRkMjTUBG+A89Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973882; c=relaxed/simple;
	bh=nUvSAuiaEX4HBWj4ToZCNnqR4r2rdRreMqR7cV5T3ls=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH3vgODcbU3Nv9w3ckva95uGl8/zZJ0WiWQ0ShGsqm4PVPZk8jEJUBfVMEh4K8nTLAr720B6vwXNamn0+dFMZWx9IG6Xie+vW7dGQ5QOlRRbskfo4G1U5P24Q+hXSBd+l3+L0FosxC48rEESvZhYAuKotnPhiKrpjpXmmYJ04bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZudwzfoH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c24ae82de4so267283285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741973879; x=1742578679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1yFqASK6gD1at4IIayHNMSsrwvf5XdOITv20pW8XxY=;
        b=ZudwzfoHgKa18Fdzz+QkKwnsI8SgTBw/7rrKM6ZYYqGILCL2HPK/NDFSU+ApQ20mG2
         aoPS+5uz2a3DFlzn+LBa7uqNqlPC4qRdLqWpx5+/eASYTGTiqZoc1YKsuz66eyZkaH/W
         Alb92+SK4J0m6j+17I68E5srCHvaM2iV2N2PHKuUyGk+vtTM9LTAhlGNbKri/VxtlJtP
         GZvhwT3H9fdCPSFvF74kvuHttx7VUKmSGff0yC1rfo679m7LBl5bVRp6SC43BMlkuJOm
         owJcVBNeEzbo8ppiz+lyMjaq9vdychkTpaxD3+pTmyzEjC9s+US6AqassifPRPZxNwCM
         xvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741973879; x=1742578679;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1yFqASK6gD1at4IIayHNMSsrwvf5XdOITv20pW8XxY=;
        b=p59yCIp+8e5u5zLSTwHpMZ0vWoU1MmXEBdO3L0GZqqnE4/Jo25vabovu4eSfBbiDjI
         7eSuoVS1GZ1Vouo/Wv3PcLdyACAvCtvRKPxpwfbF/6hvRJh/ztIvzOK6ytm82Ezke0FU
         SQJ/HQa4RcqozUXND60RjTVK1My3t3IkeL0F+v0NsavMlGMS0l2vRBb0V4YEAiFa2qeZ
         KKmQQIvqER3EOowpstwQhtVfRGxYMD0X8hy2lO1M/UP0Y+x+kIvwkfPyyKz92Yn9qaxW
         RXT/9XM39NdzLREi+W1GkYfL7+AmI7SLWf551L8zGqKsy3XHnrFcMOgT4onxHrokYNNj
         QoyA==
X-Forwarded-Encrypted: i=1; AJvYcCVYKKDpv1UlIvP3c1nodXH/8+ELMSDNXvIJDbidnHNu4lmLIhq57XN+5quPLGBygL6BcIX6lzWfjymq6O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95mm9zroqaMXITQmX0j18HxBVqnhRX5bPxe0uXEQunT7G1Xae
	81n7Ipika7ZoX8kNFhHcgEGa4O0jPqXpNkF3P/ZTk4gewPmplyAD
X-Gm-Gg: ASbGncuKtUVkYb/t1oqzTfC2WJHH4ruyc/MWHapn2DGOyDjhXzyt0Q8NhMqHArL49ds
	nRnxmrl64o9yfl3wrtccdR4H0Ms4+ye0eG0H8X3ONypJQXwgXtd9sWMY/cdQ6yKulhH6aTH+Xks
	pC7VfDFoAPaPrmWA4Gpm4y/JCxudVr63u90mnPjcU92DrgMcWnxA70wI1ojbv/DcICVuukjQWAK
	wNyuPrPiDEtkNErTQhbsfAmqrx2umUP8hdFxXxMfbArRLPhcMiYXZoE+jUibvg+Y4nrlV//UYEO
	mZvnP345IuVVb5sNwszExE3uk3aQYq0QlPXBIk0cklHUla3qeMAXZXoQsGgJW7uyZOuSwb2Ljt6
	NH+Or/ahPtxJm8AG8u36/lFzWnunwqAswLMk=
X-Google-Smtp-Source: AGHT+IGkUDXgw7JyZ5+s1/DSDLNw4hgRuF/XaSR0V/QrWF9daw2ZDv406ve+HKSlwq02NBZoTZYIEA==
X-Received: by 2002:a05:620a:4689:b0:7c5:57d6:ce3c with SMTP id af79cd13be357-7c57c7d4532mr463419885a.22.1741973879341;
        Fri, 14 Mar 2025 10:37:59 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8ab26sm280194985a.110.2025.03.14.10.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:37:58 -0700 (PDT)
Message-ID: <67d46976.050a0220.13a4aa.9cf4@mx.google.com>
X-Google-Original-Message-ID: <Z9RpcgGSoWMRQInG@winterfell.>
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 64B6D1200066;
	Fri, 14 Mar 2025 13:37:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 14 Mar 2025 13:37:58 -0400
X-ME-Sender: <xms:dmnUZ5g-xDXGSuYWRAZk2WUnxX_sC_7_YkEzTfCdtPb1450TfcKMUA>
    <xme:dmnUZ-BS4QABTTmnboP1hMfzk23ij3sY2iMAhRm7eRmw5fFPJesK90PEWMH68HaI-
    GEaBiY0RwpKFBZZRQ>
X-ME-Received: <xmr:dmnUZ5HhRW79_G54GSk5pz8f5zPzABuwCikQTX2BIM-CllAFjX51vZQzCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepihhofihorhhkvghrtdesghhmrghilhdrtghomhdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehloh
    hnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmhhhirhgrmhgrtheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehjohgvlhdrghhrrghnrgguohhssehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:dmnUZ-S8-LAIw8iXGXs98ULsd6fkTT4VNdwTc_7J9KbCDX9KrtOqaA>
    <xmx:dmnUZ2wJEernhBh8ObAqLEqFs7RPJFio1pE__zZR-5t3im9GkKw7Ag>
    <xmx:dmnUZ06nLtDMqVO70vbviVJkPWD6GFsWNynn-kgr7ksUVPQDajvNXA>
    <xmx:dmnUZ7zhsuBccwObZz45odKpOGTuyfPciW5QORH06Dy3tVIpWFbghQ>
    <xmx:dmnUZ-jR-YyvvyLaI9h4Ylt0ShdCvMiIwJjd-FqUR-gOlsHxY8yJdfJR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:37:57 -0400 (EDT)
Date: Fri, 14 Mar 2025 10:37:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
	mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org,
	anna.schumaker@oracle.com, joel.granados@kernel.org,
	kent.overstreet@linux.dev, leonylgao@tencent.com,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH RESEND v2 0/3] hung_task: extend blocking task stacktrace
 dump to semaphore
References: <20250314144300.32542-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314144300.32542-1-ioworker0@gmail.com>

Hi Lance,

On Fri, Mar 14, 2025 at 10:42:57PM +0800, Lance Yang wrote:
> Hi all,
> 
> Inspired by mutex blocker tracking[1], this patch series extend the
> feature to not only dump the blocker task holding a mutex but also to
> support semaphores. Unlike mutexes, semaphores lack explicit ownership
> tracking, making it challenging to identify the root cause of hangs. To
> address this, we introduce a last_holder field to the semaphore structure,
> which is updated when a task successfully calls down() and cleared during
> up().
> 
> The assumption is that if a task is blocked on a semaphore, the holders
> must not have released it. While this does not guarantee that the last
> holder is one of the current blockers, it likely provides a practical hint
> for diagnosing semaphore-related stalls.
> 

Could you copy John Stultz for the future versions? Because John is
working on proxy execution, which will make a task always track which
mutex it's blocked by:

	https://lore.kernel.org/lkml/20250312221147.1865364-3-jstultz@google.com/

I feel it's better to build the hung task detection with that in mind,
thanks!

Regards,
Boqun

[...]

