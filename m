Return-Path: <linux-kernel+bounces-348627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0B98E9D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA921C21E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90080C1C;
	Thu,  3 Oct 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md4R/PhX"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73D80BFC
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938359; cv=none; b=VW5rF1PvVguoZk7YW75kzJSiMRWFFR32cssWmKy9XqlmDRvalyiZ+p1Tdt5qtm8EdcBMyHCwGj4kCVR9wAJqJeoudk+CRFvvXewS8xibzikIvhBt+djYZnWCkYXi38Cch+ZJKcJkUC8KHyQywxx/IftSjJJS4yQNHhfzY+awsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938359; c=relaxed/simple;
	bh=0dQt+RUb0JKiXPf32/9Jfd/hVmmmwBuNx2fUcfKTFqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdTv93VqeRGShW6JMUk+Widve46A8Xl0vvItBfkK6X3aX2th1ym7nPzd533zsPtswZwTfTdowK9OrI/6lT79CIdWICIKMcTo1MaH6/+3/Xmc6JzRmPcOdfZHIvmD4sXTPeeH4AJ8zQsOD9ksB2na+Hr5TnIpbWwfD7AS8OWG2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md4R/PhX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8ce5db8668so95379466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727938356; x=1728543156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq6u3qfFW3ZfJOMvNwK+ddaHRyMOh9KvTsRYPWx6IY8=;
        b=Md4R/PhX/uOxH88z/M29Df8sopty3+9Athcnsp9Iql2rJvWoLvlpFfJjeAOkh32iXb
         dmphu47DdTGr+USKamhX6tGmjYIzSzbo2GPSpFqchjR/zMjucrEw2phkiAaAA/tlM3s9
         mpWvnLzGqQ+z5ekgApOiIrDAPdeKOvm21CEUgfQAMd8fmHUKizyvEPMdn78gQwiV0gm0
         3dziNEqu4NS9OVqkRFb7bncThKWg8myT+p/crdwsWzmfuX+gEH4QR4vXPg4Adjrc8wfo
         hwHCbSt7g6o8EgAn+NTAihh1D8i6w5AwCV0nDJ1YqOkKGu5lPoUiYIy7kx7U03R88XJY
         JXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938356; x=1728543156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq6u3qfFW3ZfJOMvNwK+ddaHRyMOh9KvTsRYPWx6IY8=;
        b=nfiTozf5BMzEzBwuG535VQ9HEn/Uv7WACua2GLzmMbQczB/WGR2odBu7+uBHr5iGkR
         Rv+gVIvyMAV7DL2UXV+8fEk+35Zn9G0DVSiuvjTyMFhaqTIhRpJtPHL13Zhw5c6YhWLS
         ZOTqGylDL4qc+jZWDwaw3d9t8TuP7C5nrUTNT9xwg0InzDhGdz7upSHNOK8BK0Ngezeo
         DY2/PC3xAzdUeFt7yzuYml618O4LHK7W4DDbtdBayuo1/mijCIFZO4rcRzK6EGHuMaYQ
         7ivpFgF55xc9GMy4CyW4Is3/9rCbP9ywZWqrx3WA8g7XXzyDpVJnarD/ZZPYs/602bpR
         7zxA==
X-Gm-Message-State: AOJu0YyJg+qzu+Bgb0Xefg2TQwy98KsrFsTi1Zzko8kwTG/vG60y8ORn
	J3nU0hIdLKUsZCv4WH5pbskMi14L+64/J7JUt8X0Ii5/SyyZjc63
X-Google-Smtp-Source: AGHT+IFX0gGt7qf4M4SibJ0DzmRlSK9tn3EbfZc9Fox/801YpYs6qTW6rL44cjPEgGn78V2nzUnZjA==
X-Received: by 2002:a17:907:cc87:b0:a99:22e:9658 with SMTP id a640c23a62f3a-a99022e9a7fmr292172866b.40.1727938355720;
        Wed, 02 Oct 2024 23:52:35 -0700 (PDT)
Received: from gmail.com ([45.250.247.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a991047313csm40275366b.162.2024.10.02.23.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 23:52:35 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:22:29 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: Build failure with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
References: <ytw2hroanhyyvrh2ps24l2a6qsdke5m67ynfqcqpzo7wgp3ibv@spvsq3mzltnk>
 <20241002214656.GG4017910@ZenIV>
 <20241002215413.GH4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002215413.GH4017910@ZenIV>

On 02.10.2024 22:54, Al Viro wrote:
> ... and looking at the actual code using that, just lose the entire
> array -
> 	if (memcmp(dir_entry[0].de_fname, ".", 2) ||
> 	    memcmp(dir_entry[1].de_fname, "..", 3))
> 		error = 1;
> and be done with that.

Hey sorry for the initial bad code, I'm just starting out. With your
recommendation I wrote this, does this look good?

--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -179,8 +179,7 @@ static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf)
  */
 static const char *qnx6_checkroot(struct super_block *s)
 {
-	static char match_root[2][3] = {".\0\0", "..\0"};
-	int i, error = 0;
+	int error = 0;
 	struct qnx6_dir_entry *dir_entry;
 	struct inode *root = d_inode(s->s_root);
 	struct address_space *mapping = root->i_mapping;
@@ -189,11 +188,9 @@ static const char *qnx6_checkroot(struct super_block *s)
 	if (IS_ERR(folio))
 		return "error reading root directory";
 	dir_entry = kmap_local_folio(folio, 0);
-	for (i = 0; i < 2; i++) {
-		/* maximum 3 bytes - due to match_root limitation */
-		if (strncmp(dir_entry[i].de_fname, match_root[i], 3))
-			error = 1;
-	}
+	if (memcmp(dir_entry[0].de_fname, ".", 2) ||
+	    memcmp(dir_entry[1].de_fname, "..", 3))
+		error = 1;
 	folio_release_kmap(folio, dir_entry);
 	if (error)
 		return "error reading root directory.";

-- 
Regards,
listout

