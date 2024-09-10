Return-Path: <linux-kernel+bounces-322504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806DE9729CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23F8B233C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87417A924;
	Tue, 10 Sep 2024 06:52:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161F1B85FC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951144; cv=none; b=H50k25IJMv8h7GTuPseP8pY2b+DoGUtIXRE+H4ERxLSqJQRi3p7VV8eDN131f2ZbJXDPws+6InuFdBv0juYvFFha6rP21k0KDHUvCVlkMyFWJjQbNd7p7Zh/snX+SpmDJtA4bp9gnXjgkyVJ2MFpXRwwIMcMlSIcMKzMz/6fPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951144; c=relaxed/simple;
	bh=ZKGR0JxkC1HW3JBKmLfllwzfFphotTopgfVQXuL3o3I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=jXtff18xUMaM5pKoiY43A5Nz1ksvZHgaWA4y+Gxv4n7FASGFhwv8O9TJhs718DIt1ofbmS+4R6zEdw74fhpijM//rGwAEM0vy+w/eZ48IDIK56ZrtCF0GZSxVB1k/cQJieFgCYIHaKFfffE+XYUEEJrnS+QkoXx9RLW9YYT6xO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so95319245ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725951142; x=1726555942;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0HgTBFl8cUsqeMG2e/OKsTcNZeeNSX/MuO81CJ9r0E=;
        b=ERLEqICAXd2uQAKlYLoEiLjb4lWwEElcvJ90A/Ntq+3TtfCVEpOCY4gAQPtH5ypE86
         Rl0AJMAhtANywTeUjvfm4Q5QA1GSfLwDaPkHbO8hFeOwLNIlJ3X5GXwBqOXYj9gr61qB
         5djCu63Ij6iKnfRjpCvy7V3CtdJwdVxN6hY1E5D9QwIJkiLLplbyVFbg/0tLA/nZy1HZ
         LL25XWEbctSePOjXMsZzOavBb2WxHhNUKK5/rP2L8UsbA5WrqqkS+G3iclGZvOeLDOw8
         f0IcSfGQezP6kNhpNC546ItonpcFkQ/Zmeo0F/dvhBF45ITZ1dm9pOeh2XTrqjv2rC7Y
         SA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0wC6en4gS2lWWXppuWkjZ9oZO+szgr/Dn4Y8cIBAWtlv0w6ZfNe9OU2FaVB9UvriKuPa38QvkFqSHvHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlgBLnRtOJNxwY//mDt7cqtTATYYAGVma5mw2baKJSuo3oRLk
	J0aGMyzNPYALRXhOIznJzm8EoPWHNXBP9kTenVSjQIhKK9prNPUDQqzrxc+wGoHfqtEXuu8w/un
	wXzVF+ZNx28KQiKN9ddyE6QkHrH9E+obxeRy1QvlG4UIitEAsIxrcTRs=
X-Google-Smtp-Source: AGHT+IGA17PFcKuOXbRYggDOom1eGpL19R3n8hA+dM3c5edekxSeYjM+aNiwXlQT8hqwcJbhNj2E5NFKrBAFdBJjU60g29izDumX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154a:b0:827:a979:87e4 with SMTP id
 ca18e2360f4ac-82a9621ded2mr2022299539f.10.1725951142194; Mon, 09 Sep 2024
 23:52:22 -0700 (PDT)
Date: Mon, 09 Sep 2024 23:52:22 -0700
In-Reply-To: <20240910065209.5664-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bafce70621be5041@google.com>
Subject: Re: possible fix (linux-ntfs3)
From: syzbot <syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 4fdcb5177ea1..eb935d4180c0 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -1314,7 +1314,14 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
>  	/* If we are last writer on the inode, drop the block reservation. */
>  	if (sbi->options->prealloc &&
>  	    ((file->f_mode & FMODE_WRITE) &&
> -	     atomic_read(&inode->i_writecount) == 1)) {
> +	     atomic_read(&inode->i_writecount) == 1)
> +	   /*
> +	    * The only file when inode->i_fop = &ntfs_file_operations and
> +	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
> +	    *
> +	    * Add additional check here.
> +	    */
> +	    && inode->i_ino != MFT_REC_MFT) {
>  		ni_lock(ni);
>  		down_write(&ni->file.run_lock);
>  

