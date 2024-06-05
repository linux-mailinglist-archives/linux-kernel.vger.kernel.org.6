Return-Path: <linux-kernel+bounces-201855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3A8FC444
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AFD1C24A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8E3DABE1;
	Wed,  5 Jun 2024 07:15:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062318C336
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571721; cv=none; b=aMHneuQt/rSwB+FzNK//Q6oyXOuLrlj+ddIn6lkUMAnZ85qxhPBJqtTZtUagUF2k1klRZivMWCXEwsiWcceJfz414kWUuTrl9uatntcQReHq3hcTvyzKT5x7DPyYRcW2OJbLbBIpKc2dYlhQj7bZ8b4hZx+e1o2fj+halKAuHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571721; c=relaxed/simple;
	bh=zuHsmG2l54lzUFiaM1B5Ld/DwoAs3onN3TyvEE8C2QU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=h7fcoFPw0YWOAw9TowJrFSBvaIW+OZiHLFZLiIE09DOfU9/WEP26Wr1zlDlfP0aNyIMfo0NVt570phRdvgZa1KbvAH6Wa0DUpjIQIrILY6L2vvf5poSKR814s63QpIjGjJmV/i7IVeuMcSAPWiVW9gymtc8C8R00g1HWyinGGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3746147204eso68295395ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571719; x=1718176519;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuHsmG2l54lzUFiaM1B5Ld/DwoAs3onN3TyvEE8C2QU=;
        b=R+Glko43A9/+d7BGTxKXnziNolpkkWywLChfsxEBqUSQ8gCPs2mrrpqU8RMu/Q+PON
         xEkf+aL+E9i2bwkE9yyBSdfye7RxZYAEj8iTlPJfs8+1jnH5okNCxfUgyg7cZnlWjgMv
         gterGxurj471U3E+DhHgEoJHre7tjNNg4dq0+dmq8WOtoEBFbHS9/i9bJLs7167qAxKm
         epGtlCWdF/vLYGcjvLxJx2y21bXFImuMWO5nUKlCJ1srHluUOUVtanHgV9gGg78wnFLP
         yiUY25THsDS/3XCiph9bL+CB+0LFwgFk8znbbPTXX/aL/Xamp7TkmqfFrxs3OZLMhW/y
         lv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtKLdNjq609XSuuGEeaoDQmlZkcoI7IC09D02+r2KM9OB5WVMhc2HKyG1CjJ6rY+5maf40eiTFsGUNL+Ay8ebLxLMFWHHgiG4LCLWU
X-Gm-Message-State: AOJu0YzdVU6PZKBNlxtVsHHoG3QLQCvPhMGsKsqpJ36P7LsJ49M8jLBQ
	Z/6keOrLv4mmuPzsGkuxROTdBdWBov0TJkxhISr/YfBWVcPGhIKea5hZcNKr9Xf5Tbvvg6jgzE3
	e8JRPz+G0q1EyQZs6wI+PjgtnI3knRbKDriXz33pIhZcDlr3RD3ym87Y=
X-Google-Smtp-Source: AGHT+IEXUYB9yPdeAKPB5kS6y9F3dWejMcY+PLrrOr1cr9rP+smavalbHIGbQYB6JccbQRBN3EioxR6Ty4lMAVOTE6s+agrv5VAx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168c:b0:374:9c23:a043 with SMTP id
 e9e14a558f8ab-374b1e0bb47mr1047315ab.0.1717571718590; Wed, 05 Jun 2024
 00:15:18 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:15:18 -0700
In-Reply-To: <PN2PR01MB48914D23BDE5FC72CD96A469FCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029c3f3061a1f54dd@google.com>
Subject: Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz testhttps://github.com/torvalds/linux.gite377d803b65ee4130213b3c041f=
c25fdfec1bd90

unknown command "testhttps://github.com/torvalds/linux.gite377d803b65ee4130=
213b3c041fc25fdfec1bd90"

> ________________________________
> From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
> Sent: Wednesday, June 5, 2024 09:06
> To: Wojciech Gladysz <Wojciech.Gladysz@infogain.com>
> Cc: Wojciech Gladysz <Wojciech.Gladysz@infogain.com>; linux-kernel@vger.k=
ernel.org <linux-kernel@vger.kernel.org>; syzkaller-bugs@googlegroups.com <=
syzkaller-bugs@googlegroups.com>
> Subject: Re: 000000000000fcfa6406141cc8ac@google.com
>
> EXTERNAL: This message was sent from outside of Infogain. Please do not c=
lick links or open attachments unless you know the content is safe.
>
>> #syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux=
<https://linux.googlesource.com/linux/kernel/git/torvalds/linux<https://lin=
ux.googlesource.com/linux/kernel/git/torvalds/linux>> e377d803b65ee4130213b=
3c041fc25fdfec1bd90
>
> "https://linux.googlesource.com/linux/kernel/git/torvalds/linux<https://l=
inux.googlesource.com/linux/kernel/git/torvalds/linux<https://linux.googles=
ource.com/linux/kernel/git/torvalds/linux>>" does not look like a valid git=
 repo address.
>
>>
>> The information in this email is confidential and may be legally privile=
ged. It is intended solely for the addressee and access to it by anyone els=
e is unauthorized. If you are not the intended recipient, any disclosure, c=
opying, distribution or any action taken or omitted to be taken based on it=
, is strictly prohibited and may be unlawful.

