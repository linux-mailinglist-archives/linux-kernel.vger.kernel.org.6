Return-Path: <linux-kernel+bounces-264889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92893E9BF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA83B20DC7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E278C6D;
	Sun, 28 Jul 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AcQrnW8S"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88507470
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722202825; cv=none; b=tlSZruc+lwROZiQhULHrS+ijNP2cVGrh4S7U0XKBAni8v5AIRAVhraFFHyf3N+kL/Cjf81c6k/6za9xtsEENwH2762o3Ibuk0KgS6GFCDarmCH8QdTYLwAtlTjba6ygT9OkRxuO6zStYX1OjYLUoLJu2HjLJGTy+XPVAL4ErRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722202825; c=relaxed/simple;
	bh=V4/iytO9vQHYeES3uHhvj/19GQV9N6HvXwa3EEW4CVg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jk68df4q4pack1MBZhcLe0hwBVav6gghnx/cqlm8/huqTGQz9rM5nJWBzZj9B0+crnZD42eI+r/wEjUpgUpIjU4pwn+ANZI/6uhJN26E0lnVCu7xh0IM9NmTnQ/XCdeUq7cwKufECNJ0bD+oOBruBu4jpJ+viuEIQZTtYBjQ6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AcQrnW8S; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52fc4388a64so4687129e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722202821; x=1722807621; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwbmY660ZxjP+0gllTmpeH0ekjqFQ+Ih+cUoAAOi0AE=;
        b=AcQrnW8StUxJ3wZgIKUQwY8CfT8HBmlWXxYAbkqaXRTPfvUl0zqfyLSaRDdM6AIsMn
         3U3aiK53UAeUgZjAP1H4M8n/C2LRfP+Xx5W/C6arsjhYblFy2hDu6ql/wKw73bjr3cLL
         pIZZ+9qI0fKzrb0M8opDiN/8N1Q6O+9A/dSAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722202821; x=1722807621;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwbmY660ZxjP+0gllTmpeH0ekjqFQ+Ih+cUoAAOi0AE=;
        b=bMGqtllEXBExh494ZNhrgxhaIwffMpQPyHIHPcbQaMGzqyUsFxeRxD/TE6b+rDALBE
         9BNmsaNgop8znrefBfoe1zl6x/hLPCSykpZxKlQ+dTPBb9IyQOAXjREI2GOPgNq2polg
         jG77p24IqnZgjoJAvTH3sqJS9U0Cqh4hxvMJtKdMFV+2drWtC+2+tYz/zPr3/mp5OxFR
         BEvFEPOVFSYJ0KeLdbstjraapSyY0C9vMMKY3y6FNnaYtr+RzxRaWk/9tOhgmVVUuz6a
         YCIIuO4IeHV4XR1n5hePrV4umCKwfStG/kqjhvmgvQPXww70u4SM4WUUk6QOkZr4F71d
         xHGw==
X-Gm-Message-State: AOJu0Yymhmr98atap+zN/xzo2ErdBuPFX4kt9rdT/o6wljEUuY/Br33G
	kHWU3lmD7R+05fYp1I72xF81SpzxQCji45V9olftE+3vJIMSojKzrOPTFgoM4xmddHJN9wrK0pg
	YCwSFmA==
X-Google-Smtp-Source: AGHT+IGTaze1bTTqXXY8YaW18EJ+mm9F8NqsxsFRfxxZRulBm2Gn4y/0wLSsFhd6A6eEipX/HL6Kiw==
X-Received: by 2002:a05:6512:2007:b0:52c:d13e:3785 with SMTP id 2adb3069b0e04-5309b280545mr3471460e87.30.1722202820057;
        Sun, 28 Jul 2024 14:40:20 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc42b4sm1213414e87.12.2024.07.28.14.40.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 14:40:19 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2cce8c08so33583691fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:40:19 -0700 (PDT)
X-Received: by 2002:a05:651c:4ca:b0:2ef:1db2:c02c with SMTP id
 38308e7fff4ca-2f12edf9d3bmr48365001fa.10.1722202818702; Sun, 28 Jul 2024
 14:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jul 2024 14:40:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
Message-ID: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
Subject: Linux 6.11-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The merge window felt pretty normal, and the stats all look pretty
normal too. I was expecting things to be quieter because of summer
vacations, but that (still) doesn't actually seem to have been the
case.

There's 12k+ regular commits (and another 850 merge commits), so as
always the summary of this all is just my merge log. The diffstats are
also (once again) dominated by some big hardware descriptions (another
AMD GPU register dump accounts for ~45% of the lines in the diff, and
some more perf event JSON descriptor files account for another 5%).

But if you ignore those HW dumps, the diff too looks perfectly
regular: drivers account for a bit over half (even when not counting
the AMD register description noise). The rest is roughly one third
architecture updates (lots of it is dts files, so I guess I could have
lumped that in with "more hw descriptor tables"), one third tooling
and documentation, and one third "core kernel" (filesystems,
networking, VM and kernel). Very roughly.

If you want more details, you should get the git tree, and then narrow
things down based on interests.

              Linus

---

Al Viro (1):
    struct file leak fixes

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    RTC updates
    i3c updates

Andreas Gruenbacher (1):
    gfs2 updates

Andreas Larsson (1):
    sparc updates

Andrew Morton (3):
    MM updates
    non-MM updates
    misc hotfixes

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (2):
    EFI updates
    EFI fixes

Arnd Bergmann (5):
    SoC driver updates
    SoC dt updates
    SoC defconfig updates
    arm SoC platform updates
    asm-generic updates

Bartosz Golaszewski (4):
    power sequencing updates
    gpio updates
    power sequencing fixes
    gpio fix

Benjamin Tissoires (1):
    HID updates

Bjorn Andersson (3):
    hwspinlock updates
    remoteproc updates
    rpmsg updates

Bjorn Helgaas (1):
    pci updates

Borislav Petkov (14):
    EDAC updates
    RAS updates
    x86 alternatives updates
    x86 boot updates
    x86 cleanups
    x86 confidential computing updates
    x86 uaccess update
    x86 build update
    misc x86 updates
    x86 vmware updates
    x86 cpu mitigation updates
    x86 cpu model updates
    x86 resource control updates
    x86 SEV updates

Casey Schaufler (1):
    smack updates

Catalin Marinas (1):
    arm64 updates

Chandan Babu (1):
    xfs updates

Christian Brauner (13):
    misc vfs updates
    PG_error removal updates
    vfs module description updates
    vfs casefolding updates
    vfs mount API updates
    vfs inode / dentry updates
    vfs mount query updates
    namespace-fs updates
    pidfs updates
    iomap updates
    vfs fixes x 3

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fix

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    zonefs update

Daniel Thompson (1):
    kgdb updates

Dave Airlie (3):
    drm fixes
    drm updates
    drm fixes

Dave Jiang (1):
    CXL updates

David Kleikamp (1):
    jfs updates

David Sterba (3):
    affs updates
    btrfs updates
    btrfs fix

David Teigland (1):
    dlm updates

Dipen Patel (1):
    hardware timestamp update

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    PCMCIA updates

Gabriel Krisman Bertazi (1):
    unicode update

Gao Xiang (2):
    erofs updates
    more erofs updates

Geert Uytterhoeven (2):
    m68k updates
    auxdisplay updates

Greg KH (5):
    tty / serial updates
    USB / Thunderbolt updates
    staging driver updates
    char / misc and other driver updates
    driver core updates

Guenter Roeck (1):
    hwmon updates

Helge Deller (2):
    fbdev updates
    parisc updates

Herbert Xu (1):
    crypto update

Huacai Chen (1):
    LoongArch updates

Ilpo J=C3=A4rvinen (1):
    x86 platform driver updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (5):
    locking updates
    objtool updates
    scheduler updates
    performance events updates
    x86 percpu updates

Ira Weiny (1):
    libnvdimm updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (1):
    SCSI updates

Jan Kara (2):
    fsnotify fix
    udf, ext2, isofs fixes and cleanups

Jarkko Sakkinen (3):
    tpm updates
    keys updates
    tpm fix

Jason Donenfeld (1):
    random number generator updates

Jason Gunthorpe (2):
    iommufd updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (7):
    io_uring updates
    block updates
    block integrity mapping updates
    more block updates
    io_uring fixes
    io_uring fixes
    block fixes

Joel Granados (2):
    sysctl updates
    sysctl constification

John Johansen (1):
    apparmor updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (2):
    xen updates
    xen fixes

Kees Cook (5):
    execve updates
    seccomp updates
    pstore updates
    hardening updates
    execve fix

Kent Overstreet (2):
    bcachefs updates
    bcachefs fixes

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (3):
    MFD updates
    backlight updates
    LED updates

Len Brown (1):
    turbostat updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (1):
    module update

Mark Brown (6):
    regmap updates
    regulator updates
    spi updates
    regmap fix
    regulator fixes
    spi fixes

Masahiro Yamada (2):
    Kbuild updates
    Kbuild fixes

Masami Hiramatsu (3):
    probes updates
    bootconfig update
    uprobe fix

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Micka=C3=ABl Sala=C3=BCn (2):
    landlock updates
    landlock fix

Miguel Ojeda (1):
    Rust updates

Mike Rapoport (1):
    memblock updates

Mikulas Patocka (1):
    device mapper updates

Miquel Raynal (1):
    MTD updates

Namhyung Kim (2):
    perf tools updates
    perf tools fixes

Namjae Jeon (1):
    exfat updates

Niklas Cassel (1):
    ata updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Abeni (1):
    networking fixes

Paolo Bonzini (1):
    kvm updates

Paul McKenney (6):
    arm byte cmpxchg
    memory model updates
    RCU updates
    torture-test updates
    KCSAN updates
    nolibc updates

Paul Moore (2):
    selinux update
    lsm updates

Petr Mladek (2):
    livepatching update
    printk updates

Rafael Wysocki (5):
    thermal control updates
    power management updates
    ACPI updates
    thermal control fix
    thermal control fix

Richard Weinberger (2):
    UML updates
    UBI and UBIFS updates

Rob Herring (2):
    devicetree updates
    more devicetree updates

Sebastian Reichel (2):
    HSI update
    power supply and reset updates

Shuah Khan (2):
    KUnit updates
    kselftest updates

Stephen Boyd (2):
    clk updates
    clk fixes

Steve French (3):
    smb client fixes
    smb server fixes
    more smb client updates

Steven Rostedt (4):
    tracing updates
    ftrace updates
    tracing tools updates
    tracing CREDITS file update

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (2):
    firewire updates
    firewire fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (3):
    cgroup updates
    workqueue updates
    workqueue fix

Thomas Bogendoerfer (2):
    MIPS updates
    MIPS updates

Thomas Gleixner (6):
    debugobjects update
    CPU hotplug updates
    timer updates
    interrupt subsystem updates
    MSI interrupt updates
    timer migration updates

Tzung-Bi Shih (2):
    chrome platform updates
    chrome platform firmware update

Ulf Hansson (2):
    pmdomain updates
    MMC updates

Uwe Kleine-K=C3=B6nig (1):
    pwm updates

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (3):
    dmaengine updates
    soundwire updates
    phy updates

Vlastimil Babka (1):
    slab updates

Will Deacon (3):
    iommu updates
    arm64 fixes
    iommu fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c fixes
    more i2c updates

Yury Norov (1):
    bitmap updates

