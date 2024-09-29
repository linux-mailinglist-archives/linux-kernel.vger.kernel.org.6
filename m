Return-Path: <linux-kernel+bounces-343225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD8989855
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C01C21127
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEBF14389F;
	Sun, 29 Sep 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XbL1I9aB"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600E3BB22
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727650326; cv=none; b=CjyNWCSMEso9zSK3F37j3mOzsPlkRt4+MP2pnP3toTGSyRD67cQ+oJv89HiNqQMLZjHBzGRic4+wZxU5WnEEvh1tnnBO7caNVUUwmDfUgFkY4jVZO2+9hBddD59wMMA5TqLPZk7KW4GVDyJ533tzC9bcHLS8H18e7SHkwyRQySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727650326; c=relaxed/simple;
	bh=8VOJz+vFdEBmxJ7gez1bWAVvPVjkJQnlKGJ/XubeJG0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BluMjPobpQyGd8CbIekIxyMHAn8Odh28PwKUTyXo06HeHxb2BR2TCcnGSeg8itBW4uxh8AstvIdR1cL1t8E0IEhNDMjO5p6h/+kbDtgs+zKAi68hFxxizsp/kwZQMLefa32iGMFVtC/gq3/v6IGbbh8tutj0QenPgBsu4Jsu6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XbL1I9aB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso4386984a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727650321; x=1728255121; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wLOKxCLUeWQnwwlDcfpGWR5KvGvtTdhkAO4SY36NVmo=;
        b=XbL1I9aBq9MYKkMnWHPg9eqFyXubD9rNjaccVb8gH5zPl8vDqvnZX/lrPX6m+UlGDV
         IlSGphzS/vDOcHgMkFl9KN/KVmiSrzQfCotFrzEOhqdYk2Hl/mZhhPSxM3JYwZRP182g
         myxx0zv1Hj0tRMJHIbHqvBMAav1jllnOyyYVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727650321; x=1728255121;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLOKxCLUeWQnwwlDcfpGWR5KvGvtTdhkAO4SY36NVmo=;
        b=iP69MKu3RMmIkYbB7flTV+0bzghmCThvBK6t16JnYrlbJRBCuxiryfiRo4Ro0YgNaK
         fht2fh472niDExAftk+Q6Tky2feSj+Zdyy6sjYUDVmsJxqW2hAtPFjD6lYnhsTZzfT24
         eBmoZe3f+tzNYpc8rHwkeIRhT2mXVAEXSpF+/eS3FGgLlLgp3Xi8ebr0tPljqA00VRii
         UcEJVvsoeGY0BT+sn1njCK+8kxOgfuj9KOgAZV0JrJkEGtWDjvfVuVt60kVLYmToujzW
         CrqZV3zyVlO/5jFu2rf1ELrk1chEYsNZxuH8in42UY8FuHQmv5ZVnz8lDqRk5U2Mbu4C
         4ucQ==
X-Gm-Message-State: AOJu0YxUwi3kUqFuSvXhQeNwFRoqCqBivzb3yNaRN9yUt3UwW9LC5aHp
	MWUPQ/g62G0rP/cub5SvKhYVRMjdMw8qoGlRNGnJNb+d/k+zRbBcyt3JUVhCfC964Q5Ykpgl+tJ
	AhF4=
X-Google-Smtp-Source: AGHT+IFoLJqRITC7zyA6smJPYV0gLsKMEaRDbn2NLWZukAQkTRioZ3k9Di6xKY6GsE726QfAaCCH9w==
X-Received: by 2002:a17:907:9488:b0:a8d:6073:2c13 with SMTP id a640c23a62f3a-a93c4946d42mr1069284766b.33.1727650321297;
        Sun, 29 Sep 2024 15:52:01 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947a86sm436005766b.124.2024.09.29.15.52.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 15:52:00 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a90188ae58eso487407066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:52:00 -0700 (PDT)
X-Received: by 2002:a17:907:7ea8:b0:a8d:2359:3160 with SMTP id
 a640c23a62f3a-a93c49616famr1045497166b.38.1727650320002; Sun, 29 Sep 2024
 15:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Sep 2024 15:51:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
Message-ID: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
Subject: Linux 6.12-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So two weeks have passed, and rc1 is out - the merge window is closed.

Despite conference travel (both for me and several maintainers),
things seemed to go mostly fairly normally. There's a couple of
notable new features in here: For one thing, PREEMPT_RT is now
mainlined and enabled as a config option (you do need to enable
"EXPERT" to get the question). For another, sched_ext also got merged.

That said, the bulk is - as always - all the plain old regular
updates, and that obviously means drivers dominate. We've got about
55% of the patch being drivers (and another 5% if you count the dts
files). Add in 5% doc updates, and 10% tooling (mostly perf and
selftests).

That leaves about a quarter of the overall changes as core kernel
code, split between arch updates, filesystems (yes, bcachefs, but also
btrfs, smb sever and client, netfs updates, xfs and finally core VFS
updates mostly in the form of 'struct fd' re-organisational cleanups).
And MM, core networking, Rust, security layer updates etc.

A little bit of everything, in other words. And nothing really looks
all that strange. As always, the summary below is just the log of my
merges, there's too much to list individually (some stats: 11k+
regular commits,  850+ merges, 1700+ different authors).

Let's get the testing and calming down period started, ok?

              Linus

---

Al Viro (1):
    'struct fd' updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Alexei Starovoitov (2):
    bpf updates
    bpf 'struct fd' updates

Amir Goldstein (1):
    overlayfs updates

Andreas Gruenbacher (1):
    gfs2 update

Andreas Larsson (1):
    sparc32 update

Andrew Morton (4):
    misc hotfixes
    MM updates
    non-MM updates
     misc fixes

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (1):
    perf tools updates

Arnd Bergmann (6):
    SoC devicetree updates
    SoC driver updates
    SoC defconfig updates
    SoC ARM platform updates
    asm-generic updates
    SoC update

Bartosz Golaszewski (2):
    gpio updates
    power sequencing updates

Bjorn Andersson (3):
    remoteproc updates
    rpmsg updates
    hwspinlock update

Bjorn Helgaas (1):
    pci updates

Borislav Petkov (6):
    EDAC updates
    x86 microcode loading updates
    x86 RAS updates
    x86 SEV updates
    x86 cpuid updates
    x86 hw mitigation updates

Casey Schaufler (1):
    smack updates

Chandan Babu (1):
    xfs updates

Christian Brauner (8):
    misc vfs updates
    vfs folio updates
    vfs file updates
    vfs fallocate updates
    procfs updates
    vfs mount updates
    netfs updates
    vfs blocksize updates

Christoph Hellwig (3):
    dma-mapping updates
    dma-mapping fixes
    dma-mapping fix

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (2):
    ata updates
    ata fixes

Dave Airlie (2):
    drm updates
    drm fixes

Dave Hansen (1):
    x86 SGX updates

Dave Jiang (1):
    compute express link (cxl) updates

David Kleikamp (1):
    jfs updates

David Sterba (3):
    affs updates
    btrfs updates
    btrfs fixes

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB/Thunderbolt updates
    tty / serial driver updates
    staging driver updates
    char / misc driver updates
    driver core updates

Greg Ungerer (1):
    m68knommu fixlet

Guenter Roeck (1):
    hwmon updates

Hans de Goede (1):
    x86 platform drivers updates

Helge Deller (3):
    fbdev updates
    parisc architecture updates
    fbdev fixes

Herbert Xu (2):
    crypto fixes
    crypto update

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (5):
    perf event fixes
    perf events updates
    scheduler updates
    locking updates
    x86 fixes

Ira Weiny (1):
    libnvdimm updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (1):
    networking updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (1):
    quota and isofs updates

Jarkko Sakkinen (2):
    tpm updates
    key updates

Jason Donenfeld (2):
    random number generator updates
    more random number generator updates

Jason Gunthorpe (2):
    rdma updates
    iommufd updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (5):
    io_uring updates
    block updates
    io_uring async discard support
    more io_uring updates
    more block updates

Jiri Kosina (2):
    HID updates
    HID fix

Joel Granados (1):
    sysctl update

Joerg Roedel (1):
    iommu updates

John Paul Adrian Glaubitz (1):
    sh updates

Jon Mason (1):
    PCIe non-transparent bridge updates

Jonathan Corbet (1):
    documentation update

Juergen Gross (2):
    xen updates
    more xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (3):
    pstore updates
    execve updates
    hardening updates

Kent Overstreet (2):
    bcachefs updates
    more bcachefs updates

Lee Jones (3):
    MFD updates
    LED updates
    backlight update

Linus Walleij (1):
    pin control updates

Luis Chamberlain (1):
    module updates

Mark Brown (4):
    regmap updates
    regulator updates
    spi updates
    spi fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (1):
    probes updates

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (2):
    Rust updates
    clang-format updates

Mike Marshall (1):
    orangefs update

Mike Rapoport (1):
    memblock updates

Miklos Szeredi (1):
    fuse updates

Mikulas Patocka (1):
    device mapper updates

Miquel Raynal (1):
    MTD updates

Namjae Jeon (1):
    exfat updates

Neeraj Upadhyay (1):
    RCU updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Abeni (1):
    networking fixes

Paolo Bonzini (2):
    kvm updates
    x86 kvm updates

Paul McKenney (4):
    byte cmpxchg updates
    kcsan update
    core dump update
    memory model doc updates

Paul Moore (4):
    audit updates
    selinux updates
    lsm updates
    LSM fixes

Petr Mladek (2):
    printk updates
    livepatching update

Rafael Wysocki (4):
    ACPI updates
    power management updates
    thermal control updates
    power management fix

Richard Weinberger (1):
    UML updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    HSI update
    power supply and reset updates

Shuah Khan (5):
    nolibc updates
    kselftest update
    kunit updates
    kselftest fix
    cpupower updates

Stephen Boyd (1):
    clk updates

Steve French (5):
    smb server updates
    smb client updates
    smb client fixes
    xmb client fixes
    smb server fixes

Steven Rostedt (2):
    ktest updates
    ring-buffer updates

Takashi Iwai (1):
    sound updates

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (4):
    cgroup updates
    workqueue updates
    sched_ext support
    sched_ext fixes

Tetsuo Handa (1):
    tomoyo updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (16):
    CPU hotplug updates
    clocksource watchdog updates
    irq updates
    timer updates
    debugobjects updates
    x86 build updates
    x86 cleanups
    x86 APIC updates
    x86 core update
    x86 fpu updates
    x86 FRED updates
    x86 memory management updates
    x86 platform update
    misc x86 updates
    x86 timer updates
    RT enablement

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (2):
    MMC updates
    pmdomain updates

Uwe Kleine-K=C3=B6nig (1):
    pwm updates

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (3):
    soundwire updates
    phy updates
    dmaengine updates

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    Hyper-V updates

Will Deacon (1):
    arm64 updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (3):
    i2c fixes
    i2c updates
    i2c fixes

Yury Norov (1):
    bitmap updates

