Return-Path: <linux-kernel+bounces-187602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E08CD51E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B68B23367
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41814B07E;
	Thu, 23 May 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oe/tO5NX"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721414AD23
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472643; cv=none; b=k5tLKhS19KbwRh1aKTSrvZlBckLMMRRt0SnOCyl39RARlfgaxcdg/Oi92MBweVUviGYp2yUFcEGcsz8bKIl9sdaJqvhhUPJvy9nCaQ6xacVNkB4AcGt9eHp36cb3GJ7n/W7hZuyq+TqAhVI3Fm6Xapj+pkDuIxMkIaXrQIVJJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472643; c=relaxed/simple;
	bh=tuKuhB5jKCD9ovubFiP3ySRu6UTcL+RGfPwzZ6vpe1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9qwfC5NXUftzJfXAD2oudBQ3hQLDQCqIgEnBy4UL+TvSkhOhAAeIfX28MDUl89MBZSYEwSUoV4baE+AF9FRs4Q/5hc4xLqT9kOW+7u9gT0ZtOa3Wjt03hfzJuKp6N+QPsplcGBgdF7H8ZhCql9CWjF9tUeCzWv2FnszRP6kp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oe/tO5NX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so1026293966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716472639; x=1717077439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tuKuhB5jKCD9ovubFiP3ySRu6UTcL+RGfPwzZ6vpe1s=;
        b=oe/tO5NXew7bYAcCMZTgooo65CAJaNh+nU4nrMjKPgLI8ZF9fqObOWFfJ7F8/rROo4
         ZeDLWWJpmJkEz189X3RsWutArzSwFFTMtfye8gomqXvqYwHYz2Oey/gCE5GAe6rF8uab
         8t1sXZJOsgnIe9vZsMGJfcLATDCzBoy8kYtyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716472639; x=1717077439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuKuhB5jKCD9ovubFiP3ySRu6UTcL+RGfPwzZ6vpe1s=;
        b=a2KIlv1lWX9kTkR6KhljgQC5sH8Mk623dQHHE8la0sEq/aUZaAUTPZ5igvmZhB+O8b
         qz6q1g4hci3Va3bo0dcxXMzaxcyquAD2Nj3w4WqDrS5T8NHrQyEFcCZbiNb0kLHr5Agn
         kDgFw8Nlx27md4fzQx60CriFbZKRuts1ddCWDSL2fSwbPdqsoPTPMsaTzeLibLtfXRBU
         fwfkSf3PAeSlCCT+Y6sz9fcY+4MhEVK/OO9Llal+dNnfW6kqKpR0v/J3bKS31jmSz189
         zCupuoYgH138QbQQME4aPG6zHITDB49rxSuI5RvZnrZF/sfwvQuHHoXHXewjGyKaZknk
         tpug==
X-Forwarded-Encrypted: i=1; AJvYcCULhLDlNAlfFrB4AC6DaZnfA6chxgQuFzt+XfV/3qgvKku4jI0vO+2O9lW6xuh8foLE+ya1jJw8qulb+2nGZtYjlsYhmFT0dpDB4jmv
X-Gm-Message-State: AOJu0Yw4s+TixeGWH+wgefvIO0Cp9asrZvM5LWb0/IzdVjkPi1xUtzkS
	QHaTcUAcIcps3azVvpJBy1xeIcmnPic6ntm5hc0Qe6c4c/0rmec/iMhbrDkj+YLeTPNtKb/tPzB
	6iQ4n/lqPc8EyQlD8s4CyjSGiwtXJTGAZIArCF/9piLwvo9saL1Y=
X-Google-Smtp-Source: AGHT+IGwv/ScwkgRjHdhiQCyyMyxcHqcpFc8OI2A5ZkS8UBdb6YncY2x/XHvnylSUc6CgnNomJmj0gUZnl/IESJ46A4=
X-Received: by 2002:a17:906:b202:b0:a59:c23d:85d2 with SMTP id
 a640c23a62f3a-a622814319bmr302308266b.55.1716472639470; Thu, 23 May 2024
 06:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
 <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com> <l2zbsuyxzwcozrozzk2ywem7beafmidzp545knnrnkxlqxd73u@itmqyy4ao43i>
In-Reply-To: <l2zbsuyxzwcozrozzk2ywem7beafmidzp545knnrnkxlqxd73u@itmqyy4ao43i>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 May 2024 15:57:07 +0200
Message-ID: <CAJfpegsr-5MU-S4obTsu89=SazuG8zXmO6ymrjn5_BLofSRXdg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: John Groves <John@groves.net>
Cc: linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[trimming CC list]

On Thu, 23 May 2024 at 04:49, John Groves <John@groves.net> wrote:

> - memmap=<size>!<hpa_offset> will reserve a pretend pmem device at <hpa_offset>
> - memmap=<size>$<hpa_offset> will reserve a pretend dax device at <hpa_offset>

Doesn't get me a /dev/dax or /dev/pmem

Complete qemu command line:

qemu-kvm -s -serial none -parallel none -kernel
/home/mszeredi/git/linux/arch/x86/boot/bzImage -drive
format=raw,file=/home/mszeredi/root_fs,index=0,if=virtio -drive
format=raw,file=/home/mszeredi/images/ubd1,index=1,if=virtio -chardev
stdio,id=virtiocon0,signal=off -device virtio-serial -device
virtconsole,chardev=virtiocon0 -cpu host -m 8G -net user -net
nic,model=virtio -fsdev local,security_model=none,id=fsdev0,path=/home
-device virtio-9p-pci,fsdev=fsdev0,mount_tag=hostshare -device
virtio-rng-pci -smp 4 -append 'root=/dev/vda console=hvc0
memmap=4G$4G'

root@kvm:~/famfs# scripts/chk_efi.sh
This system is neither Ubuntu nor Fedora. It is identified as debian.
/sys/firmware/efi not found; probably not efi
 not found; probably nof efi
/boot/efi/EFI not found; probably not efi
/boot/efi/EFI/BOOT not found; probably not efi
/boot/efi/EFI/ not found; probably not efi
/boot/efi/EFI//grub.cfg not found; probably nof efi
Probably not efi; errs=6

Thanks,
Miklos

