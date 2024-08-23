Return-Path: <linux-kernel+bounces-299271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2A95D22F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08931C2178C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA409189B90;
	Fri, 23 Aug 2024 15:56:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1D1885BE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428586; cv=none; b=B7DSO1MTzgQ/BA7R2i8B3hxMTaVtzVtPPRIY2zj+91wQUES67rGaeciTOePuYl0S3W2GeDlrJ7QAfyRrMYQYO2LA5kLUmB/CWS6T5hdv/ECbOBblNBLKw5G/PJtMIjj+Jn3+U3FK35yBVQVx0Zn4oKWaidMp3bp/W+2JT+KUHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428586; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pqH/BdKlFeMdgSg+walMkv4DBCb5XdF2f6yhJ9YC4g6WwA8WYKY3M+qQpGCg9mUEVP4bm9jXg9nf+fMUHCxTjWoB9tNNqxD2jfjFw80hcX1s4szw1faH3+FppURTKbik3YhsQ58wty6W408c6UrSxQMZwZhGAdyNX6rScodesJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8d1720ebso229965039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428584; x=1725033384;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=aWmUFJIm1l64hnfRUcrIC0eszqJs0WIOR4AEnFb3W1y9hntI4ceRm7K3ddWlfchF8q
         qSfLOCn6vJYQyvVgzS/MPguW4k8C/1uJ4n2XUk6tytP7jdRteSZfA1WIf+KLNidR9ffU
         4EZCKhWcwnDBkQXSSaFTDNEYFaENRm6jnMkfvhPmAzDmVNYCghYYgaY4jmF2GKP+vMej
         WRVSrR4dFSlHiiOFCK07EKcze1/Ww9lKVTDktU4uH4WXEzFphK1i6jFLwXFTPDNKQQiw
         L/hWXJDXvE74U2GlshXok4CL0tfif1ZH6d2xstzAPuHA00sGIYOYqS8GZxIizXmJLAGe
         mpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEaMlv+CvJm0yBuj5l8lb2HGtd8hgyZleLWUjhAgK6ZW0W3hxKgKrKE4NqHzthMY6924fC7hUWUAw3mYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhS1C0p2QqNo/FtU60ba4lklPciX9C+PtdA4U0iergI2TiYRre
	iOYR2EYrdx/qlVeQEGBVCFbfN7LY6Yt60nUtBMuS2CEA2ZpkwjMAL9WFISeOMjlGAZQrfHtuYeh
	+jHqMfwflRe3WhAYO1W0A6m+iy7ouiKMTjY39UPDqc/kS/ZHPV+LFiz0=
X-Google-Smtp-Source: AGHT+IEEh5whwXoHlOhYYFr4mDXKRZGElv4qidJGHeGHIHsT6Q0UBKxGnXQ58EmVCuIkAuskJ5nXde4xsk0SfCD0uw7wxfkimVDC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1485:b0:4c2:8e08:f579 with SMTP id
 8926c6da1cb9f-4ce82868421mr160517173.2.1724428584471; Fri, 23 Aug 2024
 08:56:24 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:56:24 -0700
In-Reply-To: <80acaefa59984ca89bb3b73ba6bfcdf8@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037dc4f06205bd134@google.com>
Subject: Re: UBSAN: array-index-out-of-bounds in decompress_lznt
From: syzbot <syzbot+39b2fb0f2638669008ec@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

