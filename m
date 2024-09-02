Return-Path: <linux-kernel+bounces-310620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B6A967F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C626F1C21977
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D7154BEE;
	Mon,  2 Sep 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRoixvx/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F11AACA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257470; cv=none; b=Zn7+04K39JOX0Qoi8ywGGtx36CiBIVQcu1DiN4Er1KDel6EYcT8eT8ZmqrLkKmXPHKQUY7/unGlr9YOiUHSJd9aT4MzgCmEe5C7E+z+EGuj77GHO2iLlsN3BGMSOBOVnzRGk0L/7W13MIgWwsTQOWaTycTh6eWkJ7s3ZEDT3Ruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257470; c=relaxed/simple;
	bh=MlYWtDA0Q5mTKyOcOuik7KuozIlUKzVC9dFl1KRxWgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9rM6X5S/s+D9L831t9emQ/ee7YUfBIcx6CE/RXucf/WLBuVBwyzqMNQSj2IAwW/cQ19LlOSbJTj/O1Hz17IAP16/OSUyBqCyfRX7HKf948lKNb9B4dalyoiKO7MXOpye3JjDQQa83kvY6f4sJERIpBzUEGRlo1NFZqqiZqFPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRoixvx/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427fc9834deso55955e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725257467; x=1725862267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt/pdhmIWCaDpBvzCVUeydNCVwTTuBE7DiHS/h0oVUg=;
        b=sRoixvx//aiwA51fHOxNeeaXBwoSt+dWS4sgAFE2kNdbbyXEZETGpzNnGKafxonsoR
         OKVFlGMuTUygOQ6tUU8UAvUab2unExlmlnxH4KqkpJSNEgK/Sp6cym6efYHG0IPu5Vn5
         U2suCVg7WfbiHbFC2gfKvoo27kbP7DXwpqWQ9Gfg7aNU/DnQG/I3kzC14t6nLGI68HGa
         O79ezCFLYv9dBbOU3yVoP69Lhp4OELba8Co9FWcwCFAfrvl1CU7/ZElca4q61q8sHcc8
         q7sSujMsBivMz/BdGsXy9NhnmzEFt8yB9esYu2ABPXZ1gKtdFA7WrEH+pB2qqkknf5ie
         pl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257467; x=1725862267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt/pdhmIWCaDpBvzCVUeydNCVwTTuBE7DiHS/h0oVUg=;
        b=F4CyuBnUnKTmFLnYuSYlJQLBXz7TRvMyhmGsYso2tWOAddpZtzUqCO5KZ3Kn8wOnKN
         ZAikA8fBg410n6fsnWKChFTeGWwEnD/YarsZGqD6AIWtRM3G705sWBybu/0uGWuAVIjC
         V6PZ3qM0nVXN2fQ+xQ8fnwyTb0lyEXw8qCtRw/NQ12ALgvQQYyG54+jGGEp1dq78Tv/Y
         cp10yqHxh90kU/+vk4A7u3q/nwqGDm8+C0zhh2eheHDUTpR3WiX9nEkN7xJjaCpW3oB/
         PfWbW4w/6eB7r9yr6t9Fe7lPNMyiMkSXPaLvkDglWNG+08KNCY/vyCiM0Ybiz0Ka4pJ7
         JSsg==
X-Forwarded-Encrypted: i=1; AJvYcCX4Qs2hbUUO2bYZ0uTmdpyRpdYWMjZo64gQNZZTenGzcpWO94wsHwVou4QMkDVmBxFM3Lt6vLJavE3DSjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfPY+fKb2hAB17RFIcxZox7y5Bvv34lQ8UX8QBUJy/81BZ6sU
	j7sMS1UqvB0+K3a3Yh/+bKAPtMxIV4MWU7Qpn6DgNkmt5P7+7alA2bPBv+kutQ==
X-Google-Smtp-Source: AGHT+IHKtVCpGX9bH5U9KFiXdwjXiY8dpd2rUZf/jifFQW9iyvTCQi9VEs44YJiTljvwor2vaDBCZQ==
X-Received: by 2002:a05:600c:34c9:b0:42b:892a:333b with SMTP id 5b1f17b1804b1-42c2e54127emr1907065e9.2.1725257466373;
        Sun, 01 Sep 2024 23:11:06 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b67ff88dsm7477026f8f.26.2024.09.01.23.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 23:11:06 -0700 (PDT)
Date: Mon, 2 Sep 2024 06:11:04 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 0/5] arm64: ptdump: View the second stage page-tables
Message-ID: <ZtVW-CQ-G84lHUE5@google.com>
References: <20240827084549.45731-1-sebastianene@google.com>
 <864j72vzmw.wl-maz@kernel.org>
 <8634mmvyx0.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8634mmvyx0.wl-maz@kernel.org>

On Fri, Aug 30, 2024 at 04:00:11PM +0100, Marc Zyngier wrote:
> On Fri, 30 Aug 2024 15:44:39 +0100,
> Marc Zyngier <maz@kernel.org> wrote:

Hello Marc,

> > 
> > Hi Seb,
> 
> [...]
> 
> > I've been giving this a go on my test systems with 16k pages, and it
> > doesn't really work as advertised:
> > 
> > root@babette:/sys/kernel/debug/kvm# cat 2573-13/stage2_*
> > 2
> > ---[ Guest IPA ]---
> > 0x0000000000000000-0x0000000008000000         128M 
> > 0x0000000008000000-0x00000000090a0000       17024K 3
> > 0x00000000090a0000-0x00000000090a4000          16K 3   R W X AF    
> > 0x00000000090a4000-0x000000000a000000       15728K 3
> > 
> > Only 16kB mapped? This is a full Linux guest running the Debian
> > installer, and just the kernel is about 20MB (the VM has 4GB of RAM,
> > and is using QEMU as the VMM)
> > 
> > So clearly something isn't playing as expected. Also, this '128M'
> > without a level being displayed makes me wonder. It is probably the
> > QEMU flash, but then the rest of the addresses don't make much sense
> > (RAM on QEMU is at 1GB, not at 128MB.
> > 
> > On another system with kvmtool, I get something similar:
> > 
> > root@duodenum:/home/maz# cat /sys/kernel/debug/kvm/*/stage2_*
> > 2
> > ---[ Guest IPA ]---
> > 0x0000000000000000-0x0000000001020000       16512K 3
> > 0x0000000001020000-0x0000000001024000          16K 3   R W X AF    
> > 0x0000000001024000-0x0000000002000000       16240K 3
> > 
> > and kvmtool places the RAM at 2GB. Clearly not what we're seeing here.
> > 
> > Could you please verify this?

Ughh, this doesn't look right. I will give it a spin with a different
granule, thanks for bringing me to attention. I will look first at
mm/ptdump.c if it works as intended.
 

> 
> For the record, on a 4kB host, I get much more plausible results:
> 
> root@big-leg-emma:/home/maz# cat /sys/kernel/debug/kvm/632-12/stage2_*
> 3
> ---[ Guest IPA ]---
> 0x0000000000000000-0x0000000000200000           2M 2   R     AF BLK
> 0x0000000000200000-0x0000000040000000        1022M 2
> 0x0000000040000000-0x0000000040200000           2M 2   R W X AF BLK
> 0x0000000040200000-0x0000000044000000          62M 2
> 0x0000000044000000-0x0000000044200000           2M 2   R W X AF BLK
> 0x0000000044200000-0x0000000047600000          52M 2
> 0x0000000047600000-0x0000000047800000           2M 2   R W   AF BLK
> 0x0000000047800000-0x0000000047e00000           6M 2   R W X AF BLK
> 0x0000000047e00000-0x0000000048000000           2M 2   R W   AF BLK
> 0x0000000048000000-0x00000000b9c00000        1820M 2
> 0x00000000b9c00000-0x00000000b9e00000           2M 2   R W X AF BLK
> 0x00000000b9e00000-0x00000000bb800000          26M 2
> 0x00000000bb800000-0x00000000bba00000           2M 2   R W X AF BLK
> 0x00000000bba00000-0x00000000bbe00000           4M 2   R W   AF BLK
> 0x00000000bbe00000-0x00000000bc200000           4M 2   R W X AF BLK
> 0x00000000bc200000-0x00000000bc800000           6M 2   R W   AF BLK
> 0x00000000bc800000-0x00000000be400000          28M 2
> 0x00000000be400000-0x00000000bf800000          20M 2   R W X AF BLK
> 0x00000000bf800000-0x00000000bfe00000           6M 2   R W   AF BLK
> 0x00000000bfe00000-0x00000000c0000000           2M 2   R W X AF BLK
> 
> So 16kB is the one that needs investigating, and I strongly suspect
> that 64kB is in the same boat...
> 
> Thanks,
> 
> 	M. (signing off for the day)
> 

Thanks,
Sebastian

> -- 
> Without deviation from the norm, progress is not possible.

