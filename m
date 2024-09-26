Return-Path: <linux-kernel+bounces-340614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE29875E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD1E1F221FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98C14C5AA;
	Thu, 26 Sep 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VeyTd9R8"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04623145348
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361917; cv=none; b=RDCMzJEMtkHN9iQNxgg9+CG+bUD/l5o383KvKf0Na3+rrLUnZEUaUs9Rjdlc28dNShddza7m7ZmjsSaMcuoH0kIxq/YhvB/BpP5m+0DwthX2NJIgPjRpF5GXZe+4QS2EXxn+SMyYbALDz5BcpEdahTOYGtOlrye7SiEos+s0rlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361917; c=relaxed/simple;
	bh=dsumOzFDfuh/PYFlQ5fBlwa0itLqF681cpqOcUvtv+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnWIMIqK6Y39+ZODhU1QeVKd6+1vB9iN3/RRap0yek2eSU/kgCQm5LooPACN9HBmMX3DCANJ4SDClshtPgQbT/SXJ+rz6WtKNNOEA529MSWP7R6QH8uqwKLJdNpE3hnigEM9avgiWLwyEhFjd4VDAKjYWywOadxTcFJPmjEzggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VeyTd9R8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f761461150so16837461fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727361914; x=1727966714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUk5GqFsvnt8aibuoucXH3mgAlXQnT7Fu6sM4Odfi8U=;
        b=VeyTd9R8+cruMSRIYlvO1L1twVFDeN8tss4OomfqAArVdxqGg5rlNP6/dJTdyfu6V3
         hBKl0fkg0OuRoNnW63/VeLvk9B7em36Cbcnf2Gqp0/4BJBn67uvQv+ry8hFi5yDSjsIc
         a8GEHDLtx83lBr4KcH8WHijTHKP8MtiCRHURjyDSGurE/OL6/lpPk1QxqVf8EiHx0yZz
         TNVzZ3pDHrxw7mhaAX45p5GVd9rTkNk/1N3FlqBl5y1AreZfVYwwT+srqanbuS6g/v0f
         fU5CB0OLI9I9lxOKOEvBd+ntYRVtMlLO8Iq/FKzmdsk+ivGluF7Kent+Kwap0IKHHHBN
         HYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727361914; x=1727966714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUk5GqFsvnt8aibuoucXH3mgAlXQnT7Fu6sM4Odfi8U=;
        b=Mqa86jcaH7h/Y/9KvRWMWDjoFEoWM0lSklgq4i10on35xWZ7cZQ1gNPbWviUpYbiA1
         Yl6ZpizBXneI88ORlaZ5NvAdCtg6JOGUj4JVKfLfg6mzAzihVAWboaiSxlcnqJRLS1I1
         lTgyfGq+tP0dNQ85KW128VBOVucaxgmVAhEE3GjTGhUHZ+SJL4HasG+S+Ql/zprACD7l
         uO3JXPnhso43hNV+fM8vTRUNCAQi7qFlxbfw/c/hbJFJGpMfTdzj+5gTDaGoYuChCx0d
         LeVMX369B4LeyhQ1RYvg7vXDGaC/LkkDot5efIHCgVbP24Kko7q8DTFToPiBv8wqt5rA
         Q/dw==
X-Forwarded-Encrypted: i=1; AJvYcCVBTBi+Itlq5+NNB4tmblz/yBKn9gIh75B8tX0xRwMhbvF159EteEHoyyhJni2IDRV8kLPFRn9B34knNOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Y1aS8vP08Afj03PDK8pCYvc93Mpb24qzeuBacLSOlAfih5fj
	qYFeyzusPhVqvuevfHGpnyFRLng5jjY0KQa/Szi3Rgo32z5XmO4W3bBxoAp6HIplMoLUvyiqLzH
	gia4s/3SulD58MKCevDSjXtmO1ZKrg/zlhL0VTg==
X-Google-Smtp-Source: AGHT+IFBiLue3QFOk1WR26MRKOBV5299+r2MgZ52axZ/Ki/sFLcqtDTCw32+oxmnpnFn89KL/PCW6zIy0IG54nMMM54=
X-Received: by 2002:a2e:4a0a:0:b0:2f7:6869:3b55 with SMTP id
 38308e7fff4ca-2f9cd40052emr9790031fa.21.1727361913927; Thu, 26 Sep 2024
 07:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-6-d59e61bc0cb4@linaro.org> <fc780dc2-5a69-48d8-8caa-ca2ee97d10ef@kernel.org>
In-Reply-To: <fc780dc2-5a69-48d8-8caa-ca2ee97d10ef@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 26 Sep 2024 16:45:01 +0200
Message-ID: <CAMRc=Md3itY5N1gErL-VDAz0qW6DrHPKpXzT6kNwc2HVfvchpA@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] firmware: qcom: scm: add a call for deriving the
 software secret
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Asutosh Das <quic_asutoshd@quicinc.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Bjorn Andersson <andersson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-mmc@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:23=E2=80=AFPM Konrad Dybcio <konradybcio@kernel.or=
g> wrote:
> > +
> > +     memzero_explicit(secret_buf, sw_secret_size);
> > +
> > +out_free_wrapped:
>
> Is there a reason to zero out the buffer that's being zero-allocated?
>

It's my understanding that it is a good practice in crypto routines to
immediately and explicitly zero out the memory used for storing
secrets.

Bart

