Return-Path: <linux-kernel+bounces-206216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB239005E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C21C20D94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52D195B2E;
	Fri,  7 Jun 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPuZMdpo"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC3195978
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769122; cv=none; b=sReTn81zbqtsPISvCubb2ziH5/o0WYAwI2e9ziJNSF87pCazi3d4e3XNe5UOSJZAlEBzwQPoBmN9/wUtra2CzzlE7dBFBwS6syDP1Ww/5oxZ1oVpyPFFmBIttvU2QpEHDbCBLV4qKeeN1/kKuZfF3jC92ejoHLf1QpOhIERfT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769122; c=relaxed/simple;
	bh=o1liTOMD3Ro8g5RB3ERR8eULFEran8MU4a/lyPWmCJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpJoWGeF3idGrXdChfme0n/mQxyWFQocRHjnU9xIkHMeEcX3QJw5yqoMyhlJNfKogmN/6qh4a6lBriJvaSvBx6BFxr+b2Tk5BVZfNOmCNEDqKZ5S8siia9UPOE8tMEHG9V4lL4XLQJwph1GiqOLn61Km6wl84FZG8bW3gUCqMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPuZMdpo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68f1017170so279327866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717769119; x=1718373919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1liTOMD3Ro8g5RB3ERR8eULFEran8MU4a/lyPWmCJU=;
        b=bPuZMdpoS1czTrjwcDRzt9OOd17WvBlZMCmGDg/jB44sJ3rIbMgYBJ1pXMOuzyfD69
         SmFmvytSJvKKRbte2josupdIzjcDIn+aTND5h9Yl+EUTotUvRPxkIW/v/fqN0JL7OA0Q
         GNfAbYOc2ariayYF8XT1b3mlFr3CkPV8Gfy0TYuaJGixNB7CXrdSnWnrAPTTsAF204dM
         QeAVCMCmX7AU26b9TGu8cJhSwY12raKPxEs+1joD/6WkAw2GYIwQTFd/8+cx78mM4GSD
         awfafyGNgG2gouwZS9j9gzCp6va6LOyX5E16+0FqwvKEB2B9AdTTs5URDKyUPMXYY91N
         QmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769119; x=1718373919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1liTOMD3Ro8g5RB3ERR8eULFEran8MU4a/lyPWmCJU=;
        b=ArefrxPY2ByQMuUzXLunhMGzBQzLjpgR49tJSScssZ/RzXph5L61HEL0pC1+9bCxQu
         LpRIVrOBaqPiVBwh4AA/oUzleu1gZrKj0mnQMTOpx/Ml9facTsehKdTTiRXQ4l0g/PZS
         FIzfe424E8P/ngMaqkaORl6clIjakwfMr5Ikx4YKw5WPGpgSfdPza+x7DA2XI/EsUT94
         Kk/dNY+Bpnxm6aGXeRaxZBNBo5y9fCLqWsJlYXXNo6kMcAqlPFUED5b5FMydqD+VS0G5
         copy4xdbq/6gAsP6Kbe0jN4JwqZ6kav+Sfy2KPCypD8J5+JviV++qV4KlwZQQA4ztPe1
         o0mA==
X-Forwarded-Encrypted: i=1; AJvYcCXq5hzSjUo3Ypd/l4yKZVIWVxcCW/M6fGzjydcusLq0p8cLhVWzipi8ZanJKDozn9l+D7OWP+iQcx3mCJsZM3Ub+uVBO2feaRhnvfNu
X-Gm-Message-State: AOJu0Yw9DQhNYslNtyAq60pFN2/VNRXn67+ZSxvZSuo90AY4RXXlrwUK
	C+6leYf5GBiGvOPpYhJ5wQ+uNNcuPldyRbZoat8kq4fYskJ18gyOsirhYGg+l03o38xFNe+1KXr
	ZQPLI9bAPyAKDwn0CcOoKNwz/N14=
X-Google-Smtp-Source: AGHT+IFHUZAg2HB2ql6fHgF/U3GsbqSZ2vDLjyc7FhjBqAlI20Ho/RQqr6lOdvM413CUw+SslfDXKPVfuQBZQZ5/I6Q=
X-Received: by 2002:a17:907:7295:b0:a69:1122:7c51 with SMTP id
 a640c23a62f3a-a6cdc0e7a1fmr243137966b.75.1717769118956; Fri, 07 Jun 2024
 07:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607105906.4192924-1-quic_faiyazm@quicinc.com>
In-Reply-To: <20240607105906.4192924-1-quic_faiyazm@quicinc.com>
From: =?UTF-8?B?7J2064+Z66+8?= <ldmldm05@gmail.com>
Date: Fri, 7 Jun 2024 23:05:07 +0900
Message-ID: <CACmEs-4mntpn8SQVgx5Qv9W8cmWQ__=1ds_j=vXxcDp27=SXLA@mail.gmail.com>
Subject: Re: [PATCH] kernel/reboot: enhance dmesg logging for system restart
To: Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Cc: benjamin.bara@skidata.com, dmitry.osipenko@collabora.com, lee@kernel.org, 
	daniel.lezcano@linaro.org, j.granados@samsung.com, 
	linux-kernel@vger.kernel.org, dongmin.lee@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 7:59=E2=80=AFPM Faiyaz Mohammed <quic_faiyazm@quicin=
c.com> wrote:
>
> It is useful to add the PID and Comm information along with command info.
>
> Currently, when system reboot kernel logs don not print PID and Comm:
>
> reboot: Restarting system with command 'reboot,scheduled_reboot'
> reboot: Restarting system with command 'RescueParty'
> reboot: Restarting system with command 'bootloader'
> reboot: Restarting system with command 'recovery'
> reboot: Restarting system with command 'userrequested,recovery=E2=80=99
>
> For Example after adding PID and Comm:
>
> reboot: PID: 1 Comm: init Restarting system with command 'shell'
> reboot: PID: 1 Comm: init Restarting system with command 'bootloader'

Printing out PID and COMM information might be useful for getting
which task is triggered system reboot. However, It's never a critical
information that deserves printed with pr_emerg() to whoever want the
system to be rebooted, unless the kernel is in a problematic
situation.

If reboot is called by user space via reboot system call, reboot is
never a problematic situation because it's user's intend in the
kernel's view. Other kernel codes which invokes involuntary restart
such as temperature overheat (drivers/memory/emif.c:622), already
prints out the situation before invoking system_reboot(), hence, there
is no reason to print out who called system_reboot().

Again, system reboot is not kernel panic, oops nor bug. If your intend
is to debug the reboot handler's behavior more easily, just set a
breakpoint for kernel_restart() function with gdb.

--
Best Regards,
Dongmin Lee

https://ldmsys.net/

