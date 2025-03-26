Return-Path: <linux-kernel+bounces-577118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC972A7188B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630361729C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7D1B4132;
	Wed, 26 Mar 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM1pi7ar"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246225634
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999587; cv=none; b=Ws9AQ8ff1u4VjGteEB1Imze0syjUUPuaK5Mcx8Rl4h1K7vQt3ku1I5VZOUkLDG2LHd8xuzNrSIKzmBo9knRWAlOI1qC0E6DrtgfTROOCf60gnoJd/i/rgGTc+Su3ZHsQr243MYGe0BJQSRfvpY+bJ0egHxkB9I2NyPxDMkqC3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999587; c=relaxed/simple;
	bh=M6qGQDYdrnKd0XzX+SovExI/OI3k3iR6/syeSjhXkdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTuXvkcYtOmnE1i9aG+pkHyYTocSZci2FW4ZHqsatm9gyb1dpUvggZbdDkJXEJGVHqazsUr6y0d+PBaLpFj++vzEWvGxkVq/77sGy1zm3HaJzBQ5ext8v0awbjlb4ErqI8udLN8bACp/DNhjRnZjIT8NHSiqR4JR3XyBrLUajWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM1pi7ar; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e89a2501a0so65069406d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742999584; x=1743604384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1uhRb9K89jUKMKB6y+F6EuR3ESBnpoH3ZCy82us1NA=;
        b=lM1pi7arefp9Mk3+Qsur5cQ43L5GVXrSX1nKMr43kSQLaEj3IIJzDW3QfDcBuGo4fL
         7aM8vAlPEHhcypaDuQD1uJukQei1ymhJZks1idokeN5ekMlQNQRvoHPtNcUd+YN8dL5D
         wgpulBRBUujw4VK5mgdvk2Uqn3D2FLEDUhuPNtVOuFlZYvzEheVuSiu3/HSZnSObL1CK
         jTfhkc0uVE1UjkFaFoS7nyPqUZ4pzFXdt9p9MWLJ+kJf40/lqjsacuNCpFxCWDlQxCKf
         iIcJJ0wSacTgx622+COI6ngyaBTyUing2iQAl+woH5iBTxnaUq8ramL7tMEVq58G9CCv
         BnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742999584; x=1743604384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1uhRb9K89jUKMKB6y+F6EuR3ESBnpoH3ZCy82us1NA=;
        b=U1ZztEA2FSYQ/YKmxBOOtQcnMlA1KOm+eIRdwXp+QoDDW/MJw8PHtig8hgG/bAF/QB
         wtHsJoGGyuAGG1OJRpSgbrgp7wr5kB2s5oVyKibWZFdbWdfoVo6vaUcn45/AGU2l1y/6
         HQZIusJKSucG1u276KLusPatHFcbKM23RJ4hGdr2fSsZjoD9bXDC7sDE/UAMcntTpF8D
         vF25GzStLcE+zXy5S+rRQmqMatf8a6jLt+4tzIMHYt37bGUPUltmt/StJCPAkkXNR0k8
         /Sq7nQXtOWtqO0QaQQ347yvfbEp1nGGiQPo2cE5IsEfj9JCdJm9dhAMprX5PtSlFH+ny
         BBNg==
X-Forwarded-Encrypted: i=1; AJvYcCXusiY1c5cWHIAaqsn6P75pEmN3Dvwqk4nhJ+LJgfA8h9tt0Tf9xXgiNPw8Z9Jbf1Ouz6gDq9zId2bhpGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUoUk6TuLDm2pk4sYpWALmeATcZeFoVHH9DVzUuy0k00FbsHLI
	Z+R2mi0YUr3H5LkVtjrhLyQur1Pnf6Pc2YoBaQSMCdOaiSTLnYlGRAa4MGcplfLJ6m48n8WWXV3
	+OdIr6UFYkOLdlhB84ejV3+MNoKk=
X-Gm-Gg: ASbGncu3Jvn0/XnLnfedy2928V196k35U/qaxLwqQRbkq/bvxKY56yt32d/fq16xS76
	kEvUVNN9Zx4HNL2V0ofe+Nl82B7giIq0Vjj/ZWKFwSzrGdiaLM/tOIv1pN4L9KImQADYL39HRnf
	OiDTAUY4vmUlnFsMwjzE0Lks0V
X-Google-Smtp-Source: AGHT+IEy4QwMcoxRYrmXEpDrE1WuuA/DkCs2XGD7ZcOO1nkjn3xOpqcPeYTc079GXmvxXeoFkdR9hULyEOGPkh/cy0o=
X-Received: by 2002:a05:6214:19cd:b0:6e8:f2aa:a8b0 with SMTP id
 6a1803df08f44-6eb3f2c2e84mr375223416d6.18.1742999584466; Wed, 26 Mar 2025
 07:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2C3830CD73C3B917ECA59895C90CB43BF009@qq.com>
In-Reply-To: <tencent_2C3830CD73C3B917ECA59895C90CB43BF009@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 26 Mar 2025 10:32:52 -0400
X-Gm-Features: AQ5f1JohpB2NJyAFsZS2q943wYbt3ZP4eVbj9_4_TbzAzCAIQm4S3Yxw6fAYmeg
Message-ID: <CAKEwX=N98tC5Tq+XYLgAP4MDUBAO01ceE4e+mrk9i3YniL2Vkw@mail.gmail.com>
Subject: Re: Linux6.14-rc5 BUG: spinlock bad magic in z3fold_zpool_free
To: ffhgfv <xnxc22xnxc22@qq.com>
Cc: "vitaly.wool" <vitaly.wool@konsulko.com>, linmiaohe <linmiaohe@huawei.com>, 
	akpm <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:11=E2=80=AFAM ffhgfv <xnxc22xnxc22@qq.com> wrote=
:
>
> Hello, I found a bug titled " BUG: spinlock bad magic in z3fold_zpool_fre=
e   " with modified syzkaller in the Linux6.14-rc5.
> If you fix this issue, please add the following tag to the commit:  Repor=
ted-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gm=
ail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>

Please stop using z3fold :) We already removed it upstream.

