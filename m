Return-Path: <linux-kernel+bounces-376427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822FD9AB151
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31E81C20D67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5E1A2C0B;
	Tue, 22 Oct 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QceEMfXL"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DF1A255C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608468; cv=none; b=tvpq/khU+IkkakB/BASQxo7DebwFutG+W41wvyQx1WDESceXJMRo24XUFSPKq3sofq0BknqACvFjEC5eYx4lXRKv/e3rtRkydgKfGOh8DIXPsRpqXJ3lX5S+rl88hWKtQrM3KKY+qv7+fVLoisurmZJEEnFEQdnz0jr3YtezmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608468; c=relaxed/simple;
	bh=AUnKd1M3xJOmg0hqJKHoR2GCQfujvFGd8uC2lbtp0O0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=feRWF9WuNR0Lilucy52Y/0yXQUTdL7iuiVCQMztehU0AcL+SK9Fzdqyy4Vjgp7hnIZ6/ebXuoSCibzidrvmYayNyY3wGDLtDdygqWXOnbmhdoz/FxWYob5x2ozK2kGxFSh2K+AZIDGz2XJaYzIiy1wj3/qm2jleSp2rLlMtL5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QceEMfXL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b7d95a11so19805075ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729608465; x=1730213265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvAvvPqD8Vbc7iZ14dJm8AwQMGagAK8236HrKhSHbpU=;
        b=QceEMfXLOui1NwL++tUN6xwq+ct9k0FdaM8IuzcaYfbowKPSrrVV1J17rUoqQBrk58
         EO7Umbe7SbrPnupj5acuyQIQp9+TOKoy+poSoKICwCzkdSs6YWxVWAPD1SUriIbb1+gV
         MOeR4hWmXIDXMjLHla4kdb0LoU8If/7ddP9OrE2ZrlXLHL3DoKpg75JpPQePQ5Fs8fnK
         AkOwGFdQj+SQNVCxWyOnfkaDtCBEnxH9L2D7LYEvmS7JygxTWR5q5F+jN/BnPrx1Qrs4
         YZakC9j7khvV5RwWXwaN8zZ6W0wt8DitxEClrKmnKwcTKOABzez3+E3+Ndm7SOAMwk3Y
         Pc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729608465; x=1730213265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvAvvPqD8Vbc7iZ14dJm8AwQMGagAK8236HrKhSHbpU=;
        b=qfbQ4dtoK7ELqIpGICwvD0P+WrIqvdCpb932NvKyzu5vqd2+pU28wrA7x+41GibzEk
         zQpxgSq9hGTE1Go+CFmQjaV1ChqaRUgpPsl5laYF2dUoxqq3MxW/BJnEMn1RWmIKfWU6
         ZF51ltlumT56WrzMGb5b6Pv/tFXbLa9uxZakD0nhfpN7QSi69LmAm0vO4sTuH9Er+HtZ
         SmTIKuKTVobwVq2lobg0+r/U3ws0El95Wrd4VuwWOeiKTTuUh78fz29R1ot0aKHYCeS0
         C453xNTBdSy52IiBwzO3KYezekHLwX5Qr9IXVkBZeIr0TuVcyEq5vRJ9hvbN+papXkp0
         Uf3w==
X-Forwarded-Encrypted: i=1; AJvYcCUpHeTsQWng6XlVeRbyNxbZVerYWQe7OFf5OIylkIMiWyarPhlAkavyJV1mjbV7wP1T8Ze3kxlZ0cSEhrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhW4UMf91m+IHkPxUjXg/ySuZQeIxtetamFq2PKhkpCwKL83Vs
	XUV4mAXAO9y+X/xaKsSyxwm19mcnwyNnqBloyfKxv4JKyR/nStjZvsn9BTrFdrI=
X-Google-Smtp-Source: AGHT+IFMA8/8XkeEa3fN1L/EdBNpDM5BgG5xlJL0Vg6Yh5CEnSh4WlfRGT4N951JDyO4WWAxrEdCjA==
X-Received: by 2002:a05:6e02:1ca5:b0:3a3:b559:5b92 with SMTP id e9e14a558f8ab-3a3f4060be5mr155339825ab.14.1729608465688;
        Tue, 22 Oct 2024 07:47:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fc4fsm1600289173.22.2024.10.22.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:47:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, mkoutny@suse.com, 
 Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com, 
 yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com, 
 lilingfeng3@huawei.com
In-Reply-To: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
Message-Id: <172960846463.861462.5399495567961070618.b4-ty@kernel.dk>
Date: Tue, 22 Oct 2024 08:47:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 17 Aug 2024 15:11:08 +0800, Li Lingfeng wrote:
> When a process migrates to another cgroup and the original cgroup is deleted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.
> 
> Refer to the process of deleting a disk to remove the restrictions and
> issue bios when deleting the cgroup.
> 
> [...]

Applied, thanks!

[1/1] block: flush all throttled bios when deleting the cgroup
      (no commit info)

Best regards,
-- 
Jens Axboe




