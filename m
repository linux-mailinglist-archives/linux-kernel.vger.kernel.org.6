Return-Path: <linux-kernel+bounces-426753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280C9DF74A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 23:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4A32819BE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4D1D8A14;
	Sun,  1 Dec 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RkZxxh2+"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935118593A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733093266; cv=none; b=o8XucjihqKr73KlHC1mkunMWN2Lbj3x8DSeXCrZseT5oI3nNb5gzmH6ZobmxcvL4+p/9y3yXLTKqOUL2XuvwhUnXC+O3CHc5VA1Dx88mocz7P8N3oTvNscKSAjBLcgJ32YKqidkqK79QjgH95ShSc+rpvsCaoiLZ9qjKKJ89+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733093266; c=relaxed/simple;
	bh=W8/zUCGd0ACvGv9QpiRvHsyT+yP68F5XwDBoUIYBSrc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MUCYir+dRMywHRuf/N98m4hU6JHRY67bF0grt4C5GPKRqqd5PtY6BZRxxvGu7fyBvjfyjruXfHCKOPWCyhf7UfOeZ5lblFCg3vgb/7OCGaw5B3wFiNi7lGhqfrIxG8ehccAKcqGo6DmozrdTYlp3QGSbF40QZKF/uhpWBirxXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RkZxxh2+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0374so2480070a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 14:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733093260; x=1733698060; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2nNkrXr3XpjZcIvimdKwJQMbPwGvDe1Cs2kuDB2IkM=;
        b=RkZxxh2+xQuI4k+QDcCoSkFcfAJA1NzFt8c8oyOz/9EmqIr53GxueuiBWddRYpeh8L
         AUMXEzQUuwAfMGu9+9H71MW3uIRfVXeid76diQ4a5+2Fbd1ktpYfaRUof+CYUPjua61I
         lxzf+7Fm17dII3vg29EDLUiTd5j4ksP0vwmZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733093260; x=1733698060;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2nNkrXr3XpjZcIvimdKwJQMbPwGvDe1Cs2kuDB2IkM=;
        b=C5/3pLfCkdG7Xhimwr96bxLUidsChYW1yUli5Dvq5yT2AnsnWvBijYI29Z0SqXKyuX
         PprzcAhLgyaAEdeTugdhIbeW+ok+s9O7exAak1tNbx2TCD5NSD45vpJMaTiJ6FpmJkLb
         qWrNdIfg2urUFJ3FLVpLv3Ssj1asL5nomGrSMQfIKBDiC6bnuXnCmu/0XPhNfkDm83ui
         XhF4HZQKEs2M44jlbni9RlCtE/Rx2lBNKe02QHDmwAOjCGGSuQf0COZc/HaQRaYk7gmu
         +GSgWmTzYGCF4Tr7Z5FEv6rbnPC5EVawrNjGH9KJ1dfezNi73gGslKWIpFta/MZb5yyw
         gG7w==
X-Gm-Message-State: AOJu0YwxTrTT1zTFCkmqRVpFydZxD1W7ayDApnZ/rnPonau/MUS9TNsg
	xCOs2pt3w4ZBH8oOMl031W1mi1K5JirS3TgFTsgZUGwbb3mXRP1gBZgNO83Aqqg2oG7J6GtGElI
	yVsjJLQ==
X-Gm-Gg: ASbGnctYYgv5bXu6BIXqiu0Z7fnSEtFn5jaD6ZXYUsklJvTMBj11hEOj5g7NjsbHBR4
	f/oNv4+YqyAJjnYihjXHdRFgFygtP55g0aT26aLH6SCS+JoWc2mvOmh+IYUdz+aAamgs8EWBXw0
	0Kskz9hhruN++kxinLmwo3SOml7O7Y5G8laWdf2lV7Ih73m/GGmsYWDgXQg0Itx/dkIPpzcdgVM
	EiEjESgvWNwMyqJB73ZOCWS14mcfGdtsxMr/WJSZA/4DuWu5xQUTKI5wZrkirIlA1Tev7PGbzsY
	6EhApuJyToAAt2DZwu2ELO4F
X-Google-Smtp-Source: AGHT+IHkDh0GCym4nnvRaEtx7yUdngKWqpoij4ACDMDsQVCTC1g3WEvLSQIlCMxU7h0ODwmR5ZAf1A==
X-Received: by 2002:a05:6402:3225:b0:5d0:b7c5:c3fc with SMTP id 4fb4d7f45d1cf-5d0b7c5c655mr14551629a12.3.1733093260244;
        Sun, 01 Dec 2024 14:47:40 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b264f0d2sm3256280a12.72.2024.12.01.14.47.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 14:47:39 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa51d32fa69so575842766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 14:47:38 -0800 (PST)
X-Received: by 2002:a17:907:775a:b0:a99:ff43:ca8f with SMTP id
 a640c23a62f3a-aa580ed01dcmr1925805466b.10.1733093258028; Sun, 01 Dec 2024
 14:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Dec 2024 14:47:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whiWXVxhd0BATPPd6t36HJ49vApdJXZOYuAJtRA5pRi1g@mail.gmail.com>
Message-ID: <CAHk-=whiWXVxhd0BATPPd6t36HJ49vApdJXZOYuAJtRA5pRi1g@mail.gmail.com>
Subject: Linux 6.13-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So two weeks have passed, the merge window is over, and -rc1 is pushed out.

And for once - possibly the first time ever(*) - it looks like the
release cycle doesn't clash horribly up with the holiday season, and
we'll have time both to stabilize this release, _and_ the work for
6.14 won't be starting until well into January. Sure, I'd not be at
all surprised if 6.14 ends up being smaller than average just because
people hopefully take a rest over the holidays, but that sounds like a
good thing.  I don't think we need to stretch the release timing out,
but we most certainly can just relax a bit and make the next release
smaller.

Anyway, below is my "short mergelog" as usual, since the full log is
way too big. I feel like we had more core VFS changes than usual, but
that obviously doesn't really show up in the diff stats, since those
are - as always - dominated by drivers.

             Linus

(*) Almost certainly not the first time, but it feels like we always
tend to hit Christmas head on with some timing issue.

---

Al Viro (4):
    'struct fd' class updates
    xattr updates
    ufs updates
    statx updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Alexei Starovoitov (1):
    bpf updates

Amir Goldstein (1):
    overlayfs updates

Andreas Gruenbacher (1):
    gfs2 updates

Andreas Larsson (1):
    sparc updates

Andrew Morton (2):
    MM updates
    non-MM updates

Andy Shevchenko (1):
    auxdisplay update

Ard Biesheuvel (1):
    EFI updates

Arnd Bergmann (5):
    asm-generic updates
    SoC devicetree updates
    SoC driver updates
    SoC defconfig updates
    ARM SoC updates

Bartosz Golaszewski (3):
    gpio updates
    power sequencing updates
    gpio fixes

Bjorn Andersson (2):
    remoteproc updates
    rpmsg update

Bjorn Helgaas (2):
    PCI updates
    PCI fix

Borislav Petkov (10):
    EDAC updates
    RAS updates
    x86 cache resource control updates
    x86 microcode loader update
    x86 platform cleanup
    x86 SEV updates
    x86 cpuid updates
    x86 fixes
    irq fixes
    timer fixes

Carlos Maiolino (1):
    xfs updates

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Christian Brauner (18):
    vfs multigrain timestamps
    vfs mount api conversions
    misc vfs updates
    vfs rust file abstractions
    vfs pagecache updates
    netfs updates
    vfs file updates
    overlayfs updates
    pidfs update
    copy_struct_to_user helper
    tmpfs case folding updates
    vfs untorn write support
    ecryptfs updates
    pid_namespace rust bindings
    vfs exportfs updates
    ecryptfs mount api conversion
    deny_write_access revert
    vfs fixes

Christoph Hellwig (3):
    configfs updates
    dma-mapping updates
    dma-mapping fix

Chuck Lever (1):
    nfsd updates

Daniel Thompson (1):
    kgdb updates

Dave Airlie (2):
    drm updates
    drm fixes

Dave Hansen (3):
    sgx update
    misc x86 updates
    tdx updates

Dave Jiang (1):
    cxl updates

Dave Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Fan Wu (1):
    IPE update

Frederic Weisbecker (1):
    RCU updates

Gabriel Krisman Bertazi (1):
    unicode updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB / Thunderbolt updates
    staging driver updates
    driver core updates
    char/misc/IIO/whatever driver subsystem updates
    tty / serial driver updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (2):
    hmon updates
    hwmon fixes

Heiko Carstens (2):
    s390 updates
    more s390 updates

Helge Deller (2):
    fbdev updates
    parisc architecture update

Herbert Xu (1):
    crypto updates

Huacai Chen (1):
    LoongArch updates

Ilpo J=C3=A4rvinen (1):
    x86 platform driver updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (7):
    locking updates
    objtool updates
    performance events updates
    scheduler updates
    x86 splitlock updates
    x86 cleanups
    x86 mm updates

Ira Weiny (1):
    nvdimm and DAX updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (1):
    SCSI updates

Jan Kara (3):
    quota and isofs updates
    reiserfs removal
    fsnotify updates

Jarkko Sakkinen (1):
    TPM updates

Jason Donenfeld (1):
    random number generator updates

Jason Gunthorpe (3):
    iommufd updates
    rdma updates
    more iommufd updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (4):
    block updates
    io_uring updates
    more io_uring updates
    more block updates

Jiri Kosina (1):
    HID updates

Joel Granados (1):
    sysctl updates

Joerg Roedel (1):
    iommu updates

John Johansen (1):
    apparmor updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (2):
    seccomp update
    hardening updates

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (2):
    MFD updates
    backlight updates

Len Brown (1):
    turbostat updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    modules updates
    modules fixes

Madhavan Srinivasan (1):
    powerpc fixes

Marco Elver (1):
    Kernel Concurrency Sanitizer (KCSAN) updates

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    regulator fixes
    spi fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (1):
    probes updates

Mauro Carvalho Chehab (2):
    media updates
    media fix

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Miguel Ojeda (1):
    rust updates

Mike Rapoport (1):
    memblock updates

Miklos Szeredi (1):
    fuse updates

Mikulas Patocka (1):
    device mapper updates

Miquel Raynal (1):
    MTD updates

Namhyung Kim (1):
    perf tools updates

Namjae Jeon (1):
    exfat updates

Niklas Cassel (1):
    ata updates

Palmer Dabbelt (1):
    RISC-v updates

Paolo Abeni (2):
    networking updates
    networking fixes

Paolo Bonzini (2):
    kvm updates
    more kvm updates

Paul McKenney (3):
    nolibc updates
    scftorture updates
    CSD-lock update

Paul Moore (4):
    audit updates
    selinux updates
    lsm updates
    ima fix

Petr Mladek (2):
    printk updates
    livepatching update

Rafael Wysocki (8):
    power management updates
    thermal control updates
    ACPI updates
    more power management updates
    more thermal control updates
    more thermal control updates
    morepower management updates
    more ACPI updates

Richard Weinberger (2):
    JFFS2, UBI and UBIFS updates
    UML updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    kselftest update
    kunit updates

Stafford Horne (1):
    OpenRISC update

Stephen Boyd (1):
    clk updates

Steve French (3):
    smb client updates
    smb server updates
    smb client updates

Steven Rostedt (7):
    ftrace updates
    trace ring-buffer updates
    tracing tools updates
    tracing updates
    rust trace event support
    more tracing updates
    bprintf() removal

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (3):
    workqueue updates
    cgroup updates
    sched_ext updates

Thomas Bogendoerfer (2):
    MIPS updates
    MIPS updates

Thomas Gleixner (4):
    debugobjects updates
    interrupt subsystem updates
    vdso data page handling updates
    timer updates

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (2):
    chrome platform updates
    chrome platform firmware updates

Ulf Hansson (2):
    pmdomain updates
    MMC updates

Uwe Kleine-K=C3=B6nig (1):
    pwm updates

Vinod Koul (3):
    dmaengine updates
    phy updates
    soundwire updates

Vlastimil Babka (1):
    slab updates

Wolfram Sang (3):
    i2c updates
    more i2c updates
    i2c component probing support

