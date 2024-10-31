Return-Path: <linux-kernel+bounces-390666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D19B7CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7001C216E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA081A0B12;
	Thu, 31 Oct 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZEGPv68Y"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F971A00D2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385274; cv=none; b=KE1bpeHpV7zVsRr87wVlS/jyqev+wUJkFmLazALFVKw0X1eU6HPUVyYxWORJCoGcUQalICNWnY1gdc5MT6mP3kd/ugrWjGoYn2yR/ecaiKEO3Vy/nE3IQmmxCdFgfymZhJRngKRbOLiYaCzBOO09L/TaW7mS6mFnUFJ2wAH1NzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385274; c=relaxed/simple;
	bh=pv2qiM6EvBFqBX1j8jv/8LcD+vxSMSjOiPtyRXP4wMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rppYEhIDt6pKam8WORg3eOWdtiicMzKrMf83MxlpzCAGMREFSM3IMREvEegxDNsPJygsVEBo2GOvYcYg+bWhmsnfRC0hVSrRP2TUR8myPmXUFL55sxXdgHNv1j91+BlNGPJDHR77EWT6r1D/bS3matH2CNoLzEjPwpEhUMWWksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZEGPv68Y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49VEXihY026368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730385228; bh=emrdZSEdSDwcwOd55CF+aPu5hEVvh+sQUh02acD7O6E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZEGPv68YPGhoocJljPLab58kGJNmZ3m3QdiBlh/1Gt/hhD2QJyzu32MJriQgpYHZ4
	 AOEmkVto/mg2WaiTc1y+hkKfAbG6knYu4/ZqhDfdlUYxksloP77jHXiHSd6ZdgGlPG
	 9wja9nUY4+2saneLQjqFaNxnosKDBb4wRukHxhWXwbqUO0HFsDG8XMtAmKRjrWFYR+
	 sng9INWE5PuOcHjfDX4sRI0NdKFwKcUTvrFIIfQgOtKgSKUXywSEFeH+e2lZL9W/fD
	 0UYXzD5s5Q92ROi5TclYW0r154gVE6H/Zr9BWxXVwwF3BirsnJKibPa+y1IEbAX4qY
	 8lqj0AcqzsAYQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7E0D615C05EA; Thu, 31 Oct 2024 10:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: show the default enabled prefetch_block_bitmaps option
Date: Thu, 31 Oct 2024 10:33:39 -0400
Message-ID: <173038521048.99135.9969425239769478951.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008120134.3758097-1-libaokun@huaweicloud.com>
References: <20241008120134.3758097-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 08 Oct 2024 20:01:34 +0800, libaokun@huaweicloud.com wrote:
> After commit 21175ca434c5 ("ext4: make prefetch_block_bitmaps default"),
> we enable 'prefetch_block_bitmaps' by default, but this is not shown in
> the '/proc/fs/ext4/sdx/options' procfs interface.
> 
> This makes it impossible to distinguish whether the feature is enabled by
> default or not, so 'prefetch_block_bitmaps' is shown in the 'options'
> procfs interface when prefetch_block_bitmaps is enabled by default.
> 
> [...]

Applied, thanks!

[1/1] ext4: show the default enabled prefetch_block_bitmaps option
      commit: 59daaffadc9a50ebea419fd3444a1f5c4e8db8dc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

