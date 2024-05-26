Return-Path: <linux-kernel+bounces-189886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D268CF687
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9325281ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634D84D30;
	Sun, 26 May 2024 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YvxQHboe"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97233F6
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716762726; cv=none; b=NDjb7QFaWN/yODwIMuL9mUsR7VTuPV1bvI8AUwMjDgxGqUpkPe/3ksD/AJeAI63o38W1JdEYhVyUCOFoLUI7UB6RKyx0WjB8ab8s6c9FzXtjCWaFV6Pg3b8LiqjWp8ss2Qkv6IlkRjVucBXbTPuc1Wzx0xZO5NmaGTHXDr358iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716762726; c=relaxed/simple;
	bh=PikihVp65QdTDkr0RWhrrp1lMZ4U0fLhKdIH5l10LRM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Oaw7gCiwWc516PMdEdPd3d62PaAXxgpppOVjT/r2pY5dD11gf/4KDja/ffpWlKp7M9LwOQ0HQGQOvSTNIm2TVQeFP0+aRexX3KbFUVxkB1tkIJnvTpAa3CSmVivPhVzvhVbynGg+yndMs5cBO7PvtR/17TIfSzrK43hVkl4TX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YvxQHboe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e974857588so6975181fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716762722; x=1717367522; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uX1foZ3v11EWuw2SNmx6JF5Ibp4qpumFZkihznIxd5w=;
        b=YvxQHboe39xTtTK3KldUjBbxLqPujw6byDTqmoz/VYwhVWGyhnRUMCMUBAQXPNG/11
         UicasUnKz0XWDzPFs9yCwAUI+mBrjoPKe1KMOoGY/MAJ6TgZvhqWA57NIffVFaidC5DU
         4dfTUEULxCSqM4NAhUc+rEhEy4l4iR8TcvGdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716762722; x=1717367522;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uX1foZ3v11EWuw2SNmx6JF5Ibp4qpumFZkihznIxd5w=;
        b=VwQf9T019C1XLG3pclr1QLXJX+VbGctUFnH28txUnVkDVOj3ey5IJ/6hkOsr50Ux7b
         ekjLHMKirHksLvHVjZrFBQCHQq/B/4uw5+Rcm0VZPVcyhtk8fg1UBTcGziI+x05Gx/ci
         fGnXk8Y46zGn7xW8bQJvN2XuqAxcF+pDla0kTqrz4vJpm7XM9O8g+pphHbqqcmiB006o
         mF6s2iTvrOsVVrO64ptP8ht9CQ5pBXYykHsojXycscDjNCutMWpSpZBgyKwnZhDLqP2c
         jC6s+WLCY1IkAn9o2xxdSsFPumyBEiV6jGIJRLJ26E8nyQ7BU/O3Zc3Tba0VJNmrMP78
         SAMQ==
X-Gm-Message-State: AOJu0Yy38KkShowaYGlum57XHXSMtgzS/CcDQpXASXOLXXdFg96c4vpi
	2bu97x472ZL2QsiKt5xTjabKmiFwy8k526pRe+5HJnDr6DqUdRf5FkLnwEFFKCI4ltm9DuEZnZA
	yeuUskA==
X-Google-Smtp-Source: AGHT+IHnV9/GjHEjrT5cobfrKuq0KXWBFCOOunPGcUR/9Wc9PNX7KCZQyipauutTHhQkp1YfB8krxQ==
X-Received: by 2002:a2e:7d13:0:b0:2e2:2791:983e with SMTP id 38308e7fff4ca-2e95b096b2bmr49507341fa.13.1716762722400;
        Sun, 26 May 2024 15:32:02 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdff536sm15620641fa.101.2024.05.26.15.32.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 15:32:01 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52961b77655so3012676e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 15:32:01 -0700 (PDT)
X-Received: by 2002:ac2:5388:0:b0:51c:15fa:b08 with SMTP id
 2adb3069b0e04-52966f9344dmr4534723e87.69.1716762721139; Sun, 26 May 2024
 15:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 15:31:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
Message-ID: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
Subject: Linux 6.10-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, the merge window is over, and 6.10-rc1 is tagged and pushed out.

This seems to be a regular-sized release, maybe even slightly on the
smaller side. All the stats look fairly normal, but "normal" obviously
means "much too big to post the shortlog", so below is - as always -
just my "merge log" that gives an overview of who I've merged from
with just the barest of descriptions.

We don't have any new filesystems, and the xfs online repair work
means that the bcachefs fixes aren't even the biggest filesystem
change any more. But all of that is dwarfed by all the usual driver
updates (and, as is tradition, GPU drivers are in a massive lead, with
networking a distant second and everything else is relatively small).

But we do have all the usual architecture updates, core cleanups and
fixes, tooling and documentation updates.

Please - let the testing commence,

                 Linus

---

Al Viro (4):
    vfs blocksize updates
    bdev bd_inode updates
    bdev flags update
    misc vfs updates

Alex Williamson (1):
    vfio updates

Alexander Gordeev (2):
    s390 updates
    more s390 updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andreas Larsson (1):
    sparc updates

Andrew Morton (6):
    mm updates
    non-mm updates
    more mm updates
    more non-mm updates
    more mm updates
    misc fixes

Andy Shevchenko (1):
    intel-gpio fixes

Ard Biesheuvel (2):
    EFI updates
    EFI fix

Arjan van de Ven (1):
    DSA and IAA accelerator mis-alignment fix

Arnaldo Carvalho de Melo (2):
    perf tools updates
    perf tool fix

Arnd Bergmann (7):
    SoC devicetree updates
    SoC driver updates
    ARM SoC code changes
    SoC defconfig updates
    alpha updates
    more SoC devicetree updates
    asm-generic cleanups

Bartosz Golaszewski:
    gpio updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (1):
    pci updates

Borislav Petkov (6):
    EDAC updates
    RAS update
    x86 asm alternatives updates
    x86 resource control updates
    x86 microcode loader updates
    x86 SEV updates

Chandan Babu (1):
    xfs updates

Christian Brauner (5):
    vfs iomap updates
    misc vfs updates
    vfs mount API conversions
    netfs updates
    vfs rw iterator updates

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    ipmi updates

Damien Le Moal (1):
    ata updates

Daniel Thompson (1):
    kgdb updates

Dave Airlie (3):
    drm updates
    drm fix
    drm fixes

Dave Hansen (1):
    x86 APIC update

Dave Jiang (1):
    CXL updates

David Sterba (2):
    btrfs updates
    more btrfs updates

David Teigland (1):
    dlm updates

Dipen Patel (1):
    hte/timestamp update

Dmitry Torokhov (1):
    input updates

Eric Biggers (2):
    fscrypt update
    fsverity update

Gao Xiang (2):
    erofs updates
    more erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (7):
    USB / Thunderbolt updates
    tty / serial updates
    staging driver updates
    driver core updates
    char/misc and other driver subsystem updates
    tty/serial fixes
    char/misc fix

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (2):
    fbdev updates
    parisc updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (21):
    locking updates
    perf events updates
    scheduler updates
    tip tree documentation update
    x86 asm updates
    x86 boot updates
    x86 oops message cleanup
    x86 build updates
    x86 cleanups
    x86 cpu updates
    x86 entry cleanup
    x86 fpu updates
    x86 mm updates
    x86 percpu updates
    x86 platform updates
    x86 shadow stacks
    perf event updates
    scheduler fixes
    x86 fixes
    x86 fixes
    irq fixes

Ira Weiny (1):
    nvdimm updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (1):
    SCSI updates

Jan Kara (2):
    fsnotify updates
    isofs, udf, quota, ext2, and reiserfs updates

Jarkko Sakkinen (5):
    trusted keys updates
    TPM updates
    keys updates
    asymmetric keys update
    trusted keys fixes

Jason Donenfeld (1):
    random number generator updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi updates

Jens Axboe (5):
    io_uring updates
    block updates
    more io_uring updates
    io_uring fixes
    more block updates

Jiri Kosina (1):
    HID updates

Joel Granados (1):
    sysctl updates

Joerg Roedel (1):
    iommu updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (4):
    seccomp update
    execve updates
    hardening updates
    hardening fixes

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
    modules updates

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    regmap fix
    regulator fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (2):
    bootconfig updates
    probes updates

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (1):
    Rust updates

Mike Marshall (1):
    orangefs update

Mike Snitzer (2):
    device mapper updates
    device mapper fixes

Miklos Szeredi (2):
    fuse updates
    overlayfs updates

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    MTD updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Abeni (1):
    networking fixes

Paolo Bonzini (1):
    KVM updates

Paul McKenney (3):
    cmpxchg updates
    LKMM documentation updates
    kcsan update

Paul Moore (2):
    lsm updates
    selinux updates

Petr Mladek (2):
    printk updates
    livepatching update

Rafael Wysocki (6):
    thermal control updates
    power management updates
    ACPI updates
    thermal control fixes
    ACPI fixes
    power management fixes

Richard Weinberger (2):
    UML updates
    jffs2 updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI update

Shuah Khan (4):
    nolibc updates
    kunit updates
    kselftest updates
    kselftest fixes

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (4):
    smb client updates
    smb client fix
    smb server fixes
    smb client fixes

Steven Rostedt (8):
    tracing updates
    tracing ring buffer updates
    tracing user-event updates
    tracing tool updates
    tracing cleanup
    tracing tool fix
    tracing fixes
    tracefs/eventfs updates

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    cgroup updates
    workqueue updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (4):
    timers and timekeeping updates
    x86 timers update
    interrupt subsystem updates
    x86 interrupt handling updates

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (2):
    chrome platform updates
    chrome platform firmware updates

Uladzislau Rezki (1):
    RCU updates

Ulf Hansson (2):
    pmdomain updates
    MMC updates

Uwe Kleine-K=C3=B6nig (1):
    pwm updates

Vinod Koul (3):
    dmaengine updates
    generic phy updates
    soundwire updates

Vlastimil Babka (1):
    slab updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Yury Norov (1):
    bitmap updates

