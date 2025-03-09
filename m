Return-Path: <linux-kernel+bounces-552858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77634A57FF6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 01:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305CC7A6CBF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D1410E5;
	Sun,  9 Mar 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Cd6UnOhS"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEA380
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741478910; cv=none; b=HdiYpATjArGMDBj9M2kF9zhSN5ChGKOH+Myy465q7BTn27cJAU7J4W8PaiP0blv8rrErAqe3UcQzOekixeRvUhJzAaOMGpMkzFvdKXreGjzjEmUTCYlcz9ByV8XumcucykqjZDd5JU4JPlkqxXK3TiNsk6dJydvo4jbpgILSrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741478910; c=relaxed/simple;
	bh=XkQje18o1sHvj+eapngieycehlzqZSwkWhoEiPAoSGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm2haK7YCLDf1D0Djrf/CZFtxWZSVJg/3bVKwQL1fYhpzaPJArg+ld+2igMWwo0VQP/4EIdWn0guTjur0quMPibZB20vjSENcVWtSSTeShuCZyHPLgYMXVW/hHcui4RB80nc+uYojmQrbrD+MV/V7WYoWz3ldCnr9aJlYWHtv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Cd6UnOhS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso5589553a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 16:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741478908; x=1742083708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgCgJBvkZIMBc8noi3WFpbSBR9qCOzQZcMrrRAMLJCc=;
        b=Cd6UnOhS3eCEwtKeA1GHypyLujzhYuonm6nqhfzyP9961ooX2H2AD2fYiq5CXb8hJ2
         omc/50JRHpq30NYtz4ilcW01/qjQceisHfoW6oJAV3OvulSpxyioBFkhfLrc+cC3C6XO
         w0uHb2hPsyOr5RZZx/zo4CrFnboLJIv8qC4AjE9k8D0pz0Pm2t/BYypEmpUAEARbIeEG
         azRgWZql6j6O/qdbXGDZLEFz/oi5r6YSTJ1JGesVDCXaLUA2mHdYPOZ99Di1qdcXvIXg
         b7Zlv1RwmQ/QLAprlgecePvRs2mYqNg7N6lMkh0V0b/kWA0AbuXvLofFCk9QTjgYWkNb
         P1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741478908; x=1742083708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgCgJBvkZIMBc8noi3WFpbSBR9qCOzQZcMrrRAMLJCc=;
        b=ImnN33cG4tRsgTjXP0y8Rub3In4RQk2QQMpiS+K2dlXKMYuk7RvwE9yQcrT/b0EA4d
         iJi9j5gTVij+XSM4QMnk5qKMyXweaGoF4LwQ+LB87vhkNhhpX4/0Bz4W/LzvE3DyVuje
         hu4dtrdGNDP0NoQguxn/VafP9VkwXdI2XSMoWc8Y0z1/Fk33lY5ernhr7i6sEB3+7AID
         bSszDJVOAw2SZKdApLgLJGUIHnatzWq0aUjAT8cuK1/BkiOKE4dgCcLClSFaRIY9XyCV
         dBimxEvtm4CHp4g4CEvg5eQKR8hLYpbk5yuUBhGRRLtcYWXEUTS9G6kHvcMwx4Dg7G65
         6O9g==
X-Forwarded-Encrypted: i=1; AJvYcCVMKmrENfErn0RGigCpdN1/tqC5tr7giBfe34EsyC6pwKFWT49/mlS7XiYoRPayomRDvcCWZBCpMezIA7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywvrWP0pkuGqPnfdX6jAPm+leX+3jqDMyrXry44o3l1lg2Et5
	kvI01lA52yGgvns77FZUrUxf/3uVsImqTaKb3sUEWNPVApLiajI06+2zox9WkGg=
X-Gm-Gg: ASbGncvBhaP1wY3epPkqxAaRvpuP0c3LKtpVmjpCoLneiiua4ba6+sAz+N6l1IMjU2n
	8yBbdZL6F431SP/WSvbEYdjmrhRFu1pg+6ui8w/QEnPrSvzhDfa/SNGnG/JA1mrf0oFvWRQJ4Ja
	oGknN5MNlLYANd8uXzeCgBlTuhhXQY0XkntlGi7TgOmNdr1dVH0+am8k2v+qTO7tJkoVoBcjK0Z
	SCGr/OzfBd4TEKNv5D89C4iJYyiPsobytn8BScB/mf7EpBz9Bx8fdDst3iA0r1fqDA4Bx0S9gSk
	fjRLnmTvvBbb4WXrtmplOG5iIXbi0C1xYgUut0GP
X-Google-Smtp-Source: AGHT+IFjYW7ZJ+OLH/60YBeqr+NNm0ThrbaJH5Yqhel/9cm1VDsMYXdPNanWyIsdgfurXM5lyU3qXA==
X-Received: by 2002:a05:6a20:c70b:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1f55611bdb3mr7382609637.16.1741478908372;
        Sat, 08 Mar 2025 16:08:28 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:e489:3a91:c6e6:513d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28bbf3ab0sm4009124a12.9.2025.03.08.16.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 16:08:27 -0800 (PST)
Date: Sat, 8 Mar 2025 16:08:24 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v5 4/4] entry: Inline syscall_exit_to_user_mode()
Message-ID: <Z8zb-L8bFMh_YHxO@ghost>
References: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
 <20250305-riscv_optimize_entry-v5-4-6507b5dff3ce@rivosinc.com>
 <87senn3dh1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87senn3dh1.ffs@tglx>

On Sat, Mar 08, 2025 at 01:37:30PM +0100, Thomas Gleixner wrote:
> On Wed, Mar 05 2025 at 16:43, Charlie Jenkins wrote:
> > Architectures using the generic entry code can be optimized by having
> > syscall_exit_to_user_mode inlined.
> 
> That's a pretty handwavy claim. What's the actual benefit in numbers?

I put the numbers in the cover letter! Here is the data I gathered:

Testing was done with the byte-unixbench [1] syscall benchmark (which
calls getpid) and QEMU. On riscv I measured a 7.09246% improvement, on
x86 a 2.98843% improvement, on loongarch a 6.07954% improvement, and on
s390 a 11.1328% improvement.

The Intel bot also reported "kernel test robot noticed a 1.9%
improvement of stress-ng.seek.ops_per_sec" [2]

- Charlie

> 
> Thanks,
> 
>         tglx

