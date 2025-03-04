Return-Path: <linux-kernel+bounces-545791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE04A4F169
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235BD169467
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC857251790;
	Tue,  4 Mar 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g47bFCX2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7627BF61
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130685; cv=none; b=caiv7ROjN/aPuW2kXeQxfLVZwMokRmr9AUwPkSu5VFtkFQiGq75aRMzqmvLt+mbHhF1rKxnV4xVreRhBE0KLdvdf8+mk0ZB5EV+rosv0llomzMPN84i1oLWfsZYe8j0LuZhPM3mR1GAzJqlgpnegpwNDH4xHUnoQ3f2jB/sItKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130685; c=relaxed/simple;
	bh=ft4BPe47zhRld0rPUuffwsZAusYgbs12YAc92bs01Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM3a3v+Lh2WadsVMKxSoMj1tmpRs4cDJYKYYfFJ6fu0rMBz9OY+ye4L8fVXWcozJfHJzPGNvK2BvGDXWcU7AS+P95/BiLlKUz6Jqz3A3nZfH0vtIv4HNfKVEv1x6bgC2pqqC5g0N9Aunklz6bqgW5nWF5+l1kozJYtB/60U/7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g47bFCX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741130682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srEgUoPvUOjlJVSCl5jmznUtYK/BU6V0NKB10e7D9Q8=;
	b=g47bFCX2Qad6UGEDhwTGIW2UKQEpE06Qt/8B2ftZtesGZ0su8/f9HvuuCU1JidTUWiDyfs
	o19KBGOvKK88nkYX9SbtCHM8HN1hyKzLa2yInlgxI9rOSnF7qgBrW8GlJ8PORMO7Eh+lEA
	evmOpUQne8+6otvTZkjyBCcoM4BgCgQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-FzkUkLY7MKGPdikgnqCY5g-1; Tue, 04 Mar 2025 18:24:41 -0500
X-MC-Unique: FzkUkLY7MKGPdikgnqCY5g-1
X-Mimecast-MFC-AGG-ID: FzkUkLY7MKGPdikgnqCY5g_1741130680
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3b53373f7so748741385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 15:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130680; x=1741735480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srEgUoPvUOjlJVSCl5jmznUtYK/BU6V0NKB10e7D9Q8=;
        b=j8sE4alYeX7emQpOAMjprsW+wxeV/qtBY+ft8E8RhqvF6i/GnWeiFxAXGTsn2l/yt/
         eESqa0G8ORKemGbra2HvGAPY43gmUNuS6q6dvTVno7D7fvACRB6qmmeIhLULSBB9PxAX
         Wt+jK9OOnYh8m7hV0pYuCvjSS7T2krAudi90eEIxFIHEyCLn2jYjuKko54JRl2yVeU9f
         pe3JG05peCMQs7ik3ATnUsISF/wDBXvBTxzK4D62u42T3OPJqkGLjv24I0Wl3x25AMQl
         HO/BPA6gX1b6R5jhVihHc8NBABCU2dTRcfXOBpmHdkrTKL5kaNibiB2GmieMCaxjZhC7
         ki1A==
X-Forwarded-Encrypted: i=1; AJvYcCVKNUQAFB1z+Z3l1iT+QPwmxFknsLCIY7nXesNZdZ+WqyyZdWK7bXpqqnDV3ImFcExP3SsPHOt39SuRc6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxbR/sGrZ585KuwvLrHJLXxnSl/np2Qm8S2wIvIlpqQuuupL0
	gqYSOIKjJIUkPMk8SkPg9Ah98jB3UTtKzSuWzXZjt7myEXJX4cP63YhqhcPlJzB1I5Zx8xy9duZ
	u4aB0YKSQbLR4qRV9+LfJWu2qC9lCNpQY5Dtz5cSlQ0r2w0S0m4+opZBat8JUHw==
X-Gm-Gg: ASbGnctXb78wNyCiS8gMlU2JPCOv599i1pzGDiTKP/9Zpp0gNGbA8Jo9CFrEFScLAAX
	J4+L/iK/HfGwh9O7uB5QGv9qcL2l12buROYxOZLpuwm7YjuKo+wvivMsRHf8Cfxxxj/4nKY7qI4
	4Ad9r2fbHpXNzcfyAa79IaISj3Z7+IKbtyQIZhZ62JUfHVyPabojSfqlckfQKDtuG8UMOIah1xP
	85s91TrjyLivStLtzz5DwGYHMz7RupYi+jFaOstCIdaboK69Q2TBOMyr4yS0zUx94YoDHJtlLuf
	1jy8JRU=
X-Received: by 2002:a05:620a:4c81:b0:7c0:bad7:12b5 with SMTP id af79cd13be357-7c3d8ee13demr168823585a.54.1741130680399;
        Tue, 04 Mar 2025 15:24:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6MzWOSSNkUTEXlvQ9iJOjQzvGjjEFVSlf2ZUpEyaz6kgQfPIR8TZfY2WcFT4CY7XBnhBEjw==
X-Received: by 2002:a05:620a:4c81:b0:7c0:bad7:12b5 with SMTP id af79cd13be357-7c3d8ee13demr168819085a.54.1741130680145;
        Tue, 04 Mar 2025 15:24:40 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c3edff13sm266678485a.69.2025.03.04.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:24:39 -0800 (PST)
Date: Tue, 4 Mar 2025 18:24:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	mike.kravetz@oracle.com, erdemaktas@google.com,
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com,
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org,
	bfoster@redhat.com, kent.overstreet@linux.dev, pvorel@suse.cz,
	rppt@kernel.org, richard.weiyang@gmail.com, anup@brainfault.org,
	haibo1.xu@intel.com, ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 27/39] KVM: guest_memfd: Allow mmapping guest_memfd
 files
Message-ID: <Z8eLs-53UwKHfEeK@x1.local>
References: <cover.1726009989.git.ackerleytng@google.com>
 <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:58PM +0000, Ackerley Tng wrote:
> @@ -790,6 +791,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	 */
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> +	/* TODO: Check if even_cows should be 0 or 1 */
> +	unmap_mapping_range(inode->i_mapping, start, len, 0);

Should be s/start/offset/ here, or should expect some filemap crash assert
on non-zero mapcounts (when it starts to matter).

Btw, it would be nice if the new version would allow kvm to be compiled as
a module.  Currently it uses a lot of mm functions that are not yet
exported, so AFAIU it will only build if kvm is builtin.

Thanks,

-- 
Peter Xu


