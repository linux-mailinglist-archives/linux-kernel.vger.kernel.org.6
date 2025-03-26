Return-Path: <linux-kernel+bounces-577610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3CEA71F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8925F17286F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C0253331;
	Wed, 26 Mar 2025 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A51zops7"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A22217F36
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018222; cv=none; b=aRWrS33GcdJE4H4EtGGaM0u83DMfSF8lL8Hqev+Kzn4hX75LMeXTVcAzeSSY0rkHG1hqB8Zw+bKrUJDVPfuypqx84vgTA+QDBIDCxM90zDlqOINBVIgU0GCR8tYLL2SlKtRxbiy059sA5OGSn/avC1faqh8jtI7HG2OcJxdGUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018222; c=relaxed/simple;
	bh=jiGUwXF4jKW3xbrGjLbfRJER+dO1uYrn53H54TDcNpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my1t2TBSm7kbx/rqV1Z6NWwSF5Jo6citdijqTJzI6jLa5EUjzAfD2TSHk3OQ6JEQQIQSD8f13H74G0L5PEvb+pHaP3X//5q7Gi1LfgpNxNHCPOUM3rYEB1wAYPk1maZhbVTzv2Rsi1HkODKQIADNUEoXJmMGCSEdOgUo0rn7cTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A51zops7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f94c2698so916126d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743018220; x=1743623020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rAJnZwsZb7mGPDIXjLDMJaxK1LCpW7JHjR3DY1RGnU=;
        b=A51zops7pQ7rPnOL2zyTt3jT0QQ8Kx2CvkAMK/XJQWdm0lCF07X2HYGQIo3AsumLq2
         /tklVDFFyUaIe8bXYmiAN2Gw4j5K6jP2tGzZx8m4+KwywZwHGzC9TKWuRokD3V+2sj1U
         6AV+2swjJW0abJ6cd2iyj2BafPqcQQ4GH5SzWtRGmC879YPLiHnwUPWivGJaYI2vqjao
         M2FNTW7YmwSWJuDXMN22yfodDEG3rh6+Gd9X7ReHFEtN41vvtO3Rv15Q+3rqQBd+AHYQ
         O5H3IJ/MtUzhNdawOSmwVH59qA1q6vKTMEDaa6RU2HYaLaVXnvWhNiEpW8WY9qml2Dvc
         H1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743018220; x=1743623020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rAJnZwsZb7mGPDIXjLDMJaxK1LCpW7JHjR3DY1RGnU=;
        b=VwZU3o7GF4IG4YvqExxZ60shppRprHTSTxbOEtC8mxgeYBimHJhceT9G4269et6Hci
         JBPF8uaxfq+hILtZVWTD5otbcncOSozwJHXt+UzM3A6ap8qv1u2UumRnpbJMNkIphcvg
         J9c2NZj+5N8cx6mwSSjX+evNJY6ORnaIjMxc73FgdEcZLrT5Yk0COa+fgaFLXSB6rKPC
         u4JInSxrJjXf9r2TZvmRq0o/YqzVmWPiDsGHRDFOPF0gCR8glouyn2aCL3U36s4TU/Sx
         Sp2ieq8S3y/ya96e2M1xKzdNydC8qL3YUo8G34Dh8DB8wNde+GBHBiqj04q/Go5wIC+K
         WOqg==
X-Forwarded-Encrypted: i=1; AJvYcCUC19gitSQpkxLdwXmaEdCj25ExLfRR3awhBG/pZ3gaUrcZJuDz7q37xhH7b14XHhcP9xW9p9VseE42op8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Mb6EL8tOVfaHn+k2iiVCb0FBPL4RWLwfWZze5h550xmJckzK
	pLx383K8fHpwLJJysBHJHCyhiSXxCc0jQ8n5e0wMbgB8vDai+luOGrP3PRoU8zN+IozasjU4HII
	Jr36y7Jbj0cAARjPuHbRfOYbHVuY=
X-Gm-Gg: ASbGncvmK5V8nemqEeqPc9o6DZTHghqeTaQ23wdsL+gBu05z0SBo4YwioY3JXGDRL1i
	Ht4chZxPDWocukR/7TxOmXbRY8t+7f6SZeiAOdKhJ75yaBRt1Ji2mOPpHdRAeBDFXNhBJPJJoqA
	9wLXummEsid8JpFnmaGORmbNCi
X-Google-Smtp-Source: AGHT+IFx4BHh+7k57pV1IO7HJG/9YO1INsBS9KA9AYwDRL4XjQGlSuQ8U09WiopwmrGJ0LtzI4DSAZylVangziUWRdE=
X-Received: by 2002:a05:6214:1d04:b0:6e8:8e10:424d with SMTP id
 6a1803df08f44-6ed2395e92emr10090536d6.41.1743018219414; Wed, 26 Mar 2025
 12:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2C3830CD73C3B917ECA59895C90CB43BF009@qq.com> <CAKEwX=N98tC5Tq+XYLgAP4MDUBAO01ceE4e+mrk9i3YniL2Vkw@mail.gmail.com>
In-Reply-To: <CAKEwX=N98tC5Tq+XYLgAP4MDUBAO01ceE4e+mrk9i3YniL2Vkw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 26 Mar 2025 15:43:28 -0400
X-Gm-Features: AQ5f1JpVyOQSMRIQ6FS-EzhkbRB3pXiaalELf8V-_Y0ZZZMSDxIlLI7kDWjopvQ
Message-ID: <CAKEwX=NbpaQcq_awoPKmAuPWL=D4C2W7o_9D3J_SuDFvtbo9Ag@mail.gmail.com>
Subject: Re: Linux6.14-rc5 BUG: spinlock bad magic in z3fold_zpool_free
To: ffhgfv <xnxc22xnxc22@qq.com>
Cc: "vitaly.wool" <vitaly.wool@konsulko.com>, linmiaohe <linmiaohe@huawei.com>, 
	akpm <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:32=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Wed, Mar 26, 2025 at 10:11=E2=80=AFAM ffhgfv <xnxc22xnxc22@qq.com> wro=
te:
> >
> > Hello, I found a bug titled " BUG: spinlock bad magic in z3fold_zpool_f=
ree   " with modified syzkaller in the Linux6.14-rc5.
> > If you fix this issue, please add the following tag to the commit:  Rep=
orted-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@=
gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>
>
> Please stop using z3fold :) We already removed it upstream.

To clarify a little bit - we've found that z3fold is buggy (for a very
long time), and does not outperform zsmalloc in many of the workloads
we test on (both microbenchmark and real production workloads). We've
deprecated it since 6.12:

https://github.com/torvalds/linux/commit/7a2369b74abf76cd3e54c45b30f6addb49=
7f831b

and will remove it altogether:

https://lore.kernel.org/all/20250129180633.3501650-1-yosry.ahmed@linux.dev/

Perhaps Vitaly can fix the issue for stability's sake (or in case
there is a reason why you MUST use z3fold)? But I strongly recommend
you experiment with zsmalloc :)

