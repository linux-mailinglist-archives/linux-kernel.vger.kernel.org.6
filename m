Return-Path: <linux-kernel+bounces-244719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A970E92A870
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA2D1C21192
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9311494C8;
	Mon,  8 Jul 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GctH8zc0"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C45145344;
	Mon,  8 Jul 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461195; cv=none; b=t643CV0cgbKuJ9N6b/i+godCq57VyD6fP8jDTqUqC5LFm463aQ4qUNIJ5prUeDOSV93t17cogPqkg7rHvSMgIav9mbs3fUHq1YDk9bghalthKk/vldP34RZo35s3aRYFxvz3qmTcvsWOOAJHomSSzuagTrhuZNWlxaH3S0o6LJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461195; c=relaxed/simple;
	bh=iOLaAKGVBNBu76WR45/Ccdjddni/NIVquIog/WJvECg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKtOLqnQVKSfPEZto4vDzpjModMzEm7mULZsFJ45Feci/YWeVpJRbAJSLwZCHaqgHg0jp8B1npuSmpATIqX66S3wuGpU7bqqL9FgJqbfZUoeeny6FE9Em8BYhlBsyB74yme6e17Pd4gerg6S12G15KRBrHwtoreyyNnFQySPtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GctH8zc0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e98087e32so4693134e87.2;
        Mon, 08 Jul 2024 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720461192; x=1721065992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOLaAKGVBNBu76WR45/Ccdjddni/NIVquIog/WJvECg=;
        b=GctH8zc0USblV9J1ov+1BEREUepGoaJHbJLMUGpOGjFOEU85qFUwCUYS1B4g9roV3F
         iLYsK6n2oXXLbMqFGJ65O89cdGVHymXByQQGZX4yd9l3Esflx9xvaM7cRKXG1Fn22q5z
         Yk/E1AsUhtcNeyr1Gfcz1Wm1v3tP0UBLX+ZXK9ziQeaBg2Uj8jxG4r/WZMgzzbdNkcUZ
         c9gY2e6UwbyYovLsVyB0o1aySihmoeG7jpx8E6pMMiTYOcrl9NSesW9Ml7SjPk3PrSIN
         GOihkxJI974n0fEOSgXo2O2mxa5eNzQTmN2JNAZ/ZHzDHETGWnmZw5ag1C8gLhCX0/5H
         Th1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461192; x=1721065992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOLaAKGVBNBu76WR45/Ccdjddni/NIVquIog/WJvECg=;
        b=bpSrl+AISecg8psGLd9e93Bhiozy1Ofm1k9GN/ZaG3Ka4xfHlinZrsl8KjSbhrh/FH
         kn10CmCQuTeF+BB2Vy3qroola5bVTXiMlrlLNMVc26N96HF7sR8fhjsSH5tEiK2Z2bzN
         ziG3nbQ6lZpw2fhu1bL1MSq82ljiFCRDODIvaxgoiPlSp6WZtMAQ4zA54ujjIas+HK+5
         Qp7TrLySoX6yWr14fMxiqt06RxprS7cQRW4IrJri73vPnRQpz7rZUciEVcbQLgJnrred
         bANb29gwfUigQocmckll/6O3C4QY+cpPjnqsfx7rLGEClzQb43O4snt0sVbjkSxIq//O
         9fHA==
X-Forwarded-Encrypted: i=1; AJvYcCUCKEx9U0a3gcWHEPwKZdtUSfR2ezJuFPjmJ8TVIlFuDrW+FW3zcVsFGoVdvp8d3atCE312LK+qS9CH6+F2XzE6LHb+OPGL9UFrKPkp1hVtMbPj5tEZUxnRqhy3lieIolF8jacPPL3jHYeBViY=
X-Gm-Message-State: AOJu0YyWiSRvfR9alj/aAL1rKg3Vt0atZRIqNN7JkaVSvMIKUqbhbpPn
	k0jluc3PG90RCs/ZmsM5oPZnnShs8fwiS505zY1mY7ITf6rKp+hOKfGYfK1VhzmTZ94Z9jPFNW6
	oeZV7d3IXm+wLQgwRJ4pggsiIXKU=
X-Google-Smtp-Source: AGHT+IG6OxwJnPlRecfs0gLI9tl8froTvbIEsUoz11AIQoqRN2W4OAbu0Ma5H0uhfPLdp3GnATqEA7zPVA+NU+bUB6o=
X-Received: by 2002:a05:6512:6d3:b0:52e:a008:8f41 with SMTP id
 2adb3069b0e04-52eb99916damr62580e87.25.1720461191362; Mon, 08 Jul 2024
 10:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703110624.1301830-1-wangrui@loongson.cn>
In-Reply-To: <20240703110624.1301830-1-wangrui@loongson.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jul 2024 19:52:44 +0200
Message-ID: <CANiq72m35W=8V77Rcu7MKw29EXEFq102tOL_Myyx1UvMuJYUBA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: rust: Use rustc option -Zdirect-access-external-data
To: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Xi Ruoyao <xry111@xry111.site>, Xuefeng Li <lixuefeng@loongson.cn>, loongarch@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:24=E2=80=AFPM WANG Rui <wangrui@loongson.cn> wrote=
:
>
> -Zdirect-access-external-data is a new Rust compiler option added
> in Rust 1.78, which we use to optimize the access of external data
> in the Linux kernel's Rust code. This patch modifies the Rust code
> in vmlinux to directly access externa data, using PC-REL instead of
> GOT. However, Rust code whithin modules is constrained by the PC-REL
> addressing range and is explicitly set to use an indirect method.
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

I have created a tracking issue for this in
https://github.com/rust-lang/rust/issues/127488 since there was only
the MCP, I hope that helps.

I also added it to our #2 list of unstable features -- please feel
free to ping me in the future if you add others that you will need in
the kernel, I am happy to add the entry even before you send the patch
to the kernel in order to track things (in fact, even if it is not
implemented we can still track it in the other lists).

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

