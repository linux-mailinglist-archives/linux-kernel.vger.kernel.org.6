Return-Path: <linux-kernel+bounces-226010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F90591390A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D26B1F21FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957AD629E4;
	Sun, 23 Jun 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGVmZvIY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592495A10B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719131927; cv=none; b=F4ydi9P2/WX+OifbqmjXnkuqETYDFQkynnSApLsjq7rTsuoX1AEBuh3XvQrubVOLSbvvHa67exQdBsJMobDKkqtaDVqA70Uzb8/a6zkZCwciUos5EPKyB7RG3SdhU6+2se8b0vlnGkzduaGh7/0a3dbh5F7OKw8SSl9xg2yKz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719131927; c=relaxed/simple;
	bh=QsvZBiKvcHvou+0boUCjjNJ+cHvFHTV8MhGq/+mhh5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCM8O1BavoomOe0jxELueiJcTru+xXlkTN47Tr+kUgy28W3MqWjk+Z9nC5N6Hz8bR4EPOzY9FD1/ET7QGOqnmnGVN8/86wc5gXOefha1/xRWg6qiTeyMgx5eBkAmyEDEk65HikN51oY2N7AVOXtOm8DJpFGv5RHZHeMcrc76ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGVmZvIY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7245453319so72740766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 01:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719131924; x=1719736724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsvZBiKvcHvou+0boUCjjNJ+cHvFHTV8MhGq/+mhh5Q=;
        b=HGVmZvIYzahDbfgB7zWTW/S/cvYtP5oDW9XmvrfVhHA/c0PN0ygWEuhwAWmUW3O92N
         chtkjnEyg9Cv8bYcQSQlSKJrXTMhFmP3Y3GhPGJY1jgnMmz4umYbslCqvE0Wt28FiyHt
         csXPIWbx2NyQelQChTDBxsS5RwhoxApqVtINlWddZjk0N9/SsX7a3FqX9iZU6NLIXaj8
         G6v8E88oDP2H3fTuW9DdT9jR53Ncvjri/aTAq4BNchzC/U8Qee6TtyA2uoOCGUNDUlKN
         fibpdxAOgI1OAPnJeIlTcPR+Ge1GOwvNp61v7o2MWYoMu/sTfJnGclsTT3B7VY77JMX2
         VDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719131924; x=1719736724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsvZBiKvcHvou+0boUCjjNJ+cHvFHTV8MhGq/+mhh5Q=;
        b=W1hq6i2GpvuEu9+lx9/zIQqkQfebevYwNmJCpCP1OOaCxWhh/7PgfZGnBvyhOqa0FU
         SG7THWvvDkbZ9bWrsCJEyPSrqKd03RKSSaVNbOT2XMJCFTONCmwCE+Nu6Xho2UwMU5NG
         CAOM+wxsKBmhbSVL53JQY/VxiRPGULNZ5jzDIgX9T14gwZUEul/btpZO1Ymo2UWFHW9V
         AoU9KP7kNNuu08zh1HiKiGRGrLMZhsuWJiWjSTV7iNY1XXnWgSrXfuWzakCR+HLq2rqi
         ICn141svbu4pf0Pr3DKD6u0Io0P7jal86f4pwhZQcgErX7kNamZD0IWZR3yL/YgV4swj
         nVOw==
X-Forwarded-Encrypted: i=1; AJvYcCUspbaONj48F5sZwAclYJPcC//hZiaFFF88r5dG1aNiIxZt5+iy1HnYTCOtpMklwQKItXrL18/o/szBZrdqY6+k5ZHnM0m0Q+E+UCoV
X-Gm-Message-State: AOJu0Yw5navgBPgZK7Kfn3a8CrIe/E8bcTBRctNHQxZm9iy1dR1wNrqk
	KTfro8a0tsm90Ac6W2IeQ5Y9ZwktAYdH1Ovv0rtxJ4tq9VXPykDHNXz74ECXdAXPYZ4m9dIsTrQ
	pL8NAm7zssNqiFpp8LlIN6xfrMOg=
X-Google-Smtp-Source: AGHT+IEXX8VbYw8vknrUcUOe6Lx9SOjzX2TCFUsGPPaWCwb8IUPUwU+WThSU3Gavqk0Q3m73pv91V1u/yyYawwQJ7Ec=
X-Received: by 2002:a17:906:3593:b0:a6f:b352:a74b with SMTP id
 a640c23a62f3a-a700e7334d5mr197419166b.38.1719131924431; Sun, 23 Jun 2024
 01:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607105906.4192924-1-quic_faiyazm@quicinc.com>
 <CACmEs-4mntpn8SQVgx5Qv9W8cmWQ__=1ds_j=vXxcDp27=SXLA@mail.gmail.com> <066a05ca-e2e8-4cfe-8d33-60a665495cdf@quicinc.com>
In-Reply-To: <066a05ca-e2e8-4cfe-8d33-60a665495cdf@quicinc.com>
From: Dongmin Lee <ldmldm05@gmail.com>
Date: Sun, 23 Jun 2024 17:38:33 +0900
Message-ID: <CACmEs-6+GW=pmeWnyE4CZ8hk5PBA_9KOXj+MrkhZ2EcePdC0rg@mail.gmail.com>
Subject: Re: [PATCH] kernel/reboot: enhance dmesg logging for system restart
To: Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Cc: benjamin.bara@skidata.com, dmitry.osipenko@collabora.com, lee@kernel.org, 
	daniel.lezcano@linaro.org, j.granados@samsung.com, 
	linux-kernel@vger.kernel.org, dongmin.lee@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 8:09=E2=80=AFPM Faiyaz Mohammed
<quic_faiyazm@quicinc.com> wrote:
> Agreed in kernel view user's space reboot is intended but if system is
> silently rebooting due to any user process(vendor specific user process
> or even a OS specific user deamon) meeting any error condition then a
> developer debugging the system need to know which user process is
> issuing reboot system call to debug further, so in humble opinion it is
> helpful for system debug perspective.

Your situation is where system call tracing is required. Tracing
itself (via printing out kernel backtrace and/or comm and name) is
actually not what system calls should support regardless of debugging
level and/or kconfig option.

As I mentioned in earlier mail, you might use gdb debugger for the
purpose, or you might utilize SystemTap or eBPF to trace system calls
(including reboot call), actually these are for you to do system call
tracing rather than unnecessarily modifying system call's behavior.

You might want to refer to: https://lwn.net/Articles/852112/

Sincerely,
Dongmin Lee
https://ldmsys.net/

