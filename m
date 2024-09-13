Return-Path: <linux-kernel+bounces-327639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569FE9778A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D9B1F25BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F919C552;
	Fri, 13 Sep 2024 06:12:49 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2D4A07
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207969; cv=none; b=Si2ws2rAcX2u/Ge5jMvCFHUbahCXRyryYVnoRGnhmeP6ijW0RTQJVUWB0S6ofxCvfeN8XsyIne+qV4QPSbTuYx/9vKN0Ushb9OOaTDFAwtrs7YxDCIR9LHoJ0bNg3l6ADTW4YkMGRhDtoZfuh7TxOKT04ayCj/gW+8j9MiycVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207969; c=relaxed/simple;
	bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=p2awrOsmtEfakeuvbx7IPoBgzLl8v1Uzyo2zpflERXWRz+iDWbJNNsFRWbYtBCCzuhf9Wh5dqme13VQAi6zk+XkBs+cRlK/JWMHMCgqh/7TG9t/iLA2ZUzluyXFYDg0253yiNwcPfh0eyABAliVfEO2mppAL/HWm8MJ/a/to9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04af50632so21298255ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726207967; x=1726812767;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=t23i8yA21ycVefpS84WevUJ1A2Z4jkrBRwr1u8Cut7mAt6SNlTy0jC3VKFN99FcfjE
         pyTt/7Q+UBvjEIGWooat8c2MSIjX9vokDZWtP+NUAMbJdmWRGQzSD0kYK76xnymckzPL
         b9DNn8MGF5AErymPqCiOCcPFDZ1bsMHA2gQtSVfAJEziBJvbBCrliTXq84pRumHOSBCs
         reBVbhe2ObxcF11qixUo4Xdi4VEQv/yV+tSEQRTkkPQxmYQ3P2/IhcMI0gNVzb659RaH
         x+ayqOLbnPibUYv+O2CwfVqslRHCE7Bf4W/jBgIs9+5ZrD1G0pIFGszNdDnWOpdR2zOS
         VVgA==
X-Forwarded-Encrypted: i=1; AJvYcCUGjLjtuBwyIIQoLl67qaRoQpdPSIdyylb9sufa+vgkxDQBMGaB39u0yU+fjndvHJjajs8nLoPrc5eligQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxaIWEw16uLRFSE7ywYd3+JsVJVUXJNV482H+hgRHaFEiO/apa
	PyD5WGIpiWswfOiYlGxz1ZfWtyCb6tlM4yT27G6xMMltx+rqGgAaOAxiKPllEuyraIDABlIxg9t
	FdbB3uINVpNzh7gI5ZkbZK3XcTv5ka1sOaaCL2ZwJpwfXnICbS8PtJcU=
X-Google-Smtp-Source: AGHT+IFHb5+ZJpVj/h3QU9Yeh0LWhz8EOVqiOBp+eCMjgo35REwgL49FXDrLw/jH+7A78NHf6kmxBzcXiPwPL0gmgrDV1WcRGRKg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e2:b0:39b:20d8:601e with SMTP id
 e9e14a558f8ab-3a0848afb8dmr54347645ab.3.1726207967388; Thu, 12 Sep 2024
 23:12:47 -0700 (PDT)
Date: Thu, 12 Sep 2024 23:12:47 -0700
In-Reply-To: <CACb6ct1qzNF6EBO0XW1ceb_npTKz5WdbB_TsuYX_r_jBT9qpvw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b47c120621fa1c35@google.com>
Subject: Re: KASAN: slab-use-after-free Read in hugetlb_fault (2)
From: syzbot <syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com>
To: ksjoe30@gmail.com
Cc: ksjoe30@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.


