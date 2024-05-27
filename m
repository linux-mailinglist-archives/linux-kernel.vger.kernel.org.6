Return-Path: <linux-kernel+bounces-190687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F988D0164
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8032865DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA413BAC2;
	Mon, 27 May 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8URyEOL"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063615E5CC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816357; cv=none; b=du9XPCDd3q4igVopUX3vapyRN+HGsu3/ckDLT4zBOBQ2LxKqxmufjT1l7cIlpDCn8g+uv/yIq6CvZ27O2yPacF3XyatR9egVUTe0S4c3fduea158RZ1Uiaq3QuT/QS++rgOQk6kJuM+3DtBz31s6SfvH3uKvtVWtT/LOJzX/81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816357; c=relaxed/simple;
	bh=CtRkM4NHWReSfFB0jbMhH57Nmgwzp2sPsI0917uvuXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLsoG0nSxI1SBAeuDYW5G1etEJ40JLzl2qrvOGwf9DRdmDui381fRKDuGQGG2HqtLLSSSZ1eNFeibZeZCFoI4AqZ93j83D+7OKaJJAk550JVd+StHMB2TdDjbsfZ8SAq9YD2DfUv935N6BfJpzULLd0VU5tE+umzXeRdTLezHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i8URyEOL; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-df4e6ece05aso4918678276.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816355; x=1717421155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtRkM4NHWReSfFB0jbMhH57Nmgwzp2sPsI0917uvuXs=;
        b=i8URyEOLadh3aJS3aN7uEwEwt71X1uRkE5Uc9Xq+hwlqRdXhDol/qb23aJx0S675ME
         5JM0kUTWxOmQlYdTj1J2NoJBQ4guC9rCWlgMgbxrGm8/oj/DnzCIeG2gWx8BZTsxiJfu
         MvP8k3Oyzj/okPEdvAv2oC59QDnSMBQsRpyHbaiRZGfiEkjedI2wVbec89kp4GKBIHFa
         fnYl9SaGpkVG2Ya0WB99dXMR2SdSObu/9vqIo6txfXDGrgj7LDhkCy0NSDvL/1PZl3nz
         VA9gKutl0OH3Rhp03MpgIaDePu8p/YDuz8gwgWhIyAXMwdLsrxE4LkmDAiM0o/UD8gf+
         cRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816355; x=1717421155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtRkM4NHWReSfFB0jbMhH57Nmgwzp2sPsI0917uvuXs=;
        b=nrCfrNJXdgHU6QE+nXN/aSk1jciUb09/ccNf1CQEzEIUZD+ncSdVM1QXKd4pXyYi2w
         hE8Fj1lb8Bo66ZOsheNGzbcfNdeYBJCRN7i49Mq3n1uGzcAy8Lt24S9f2QDkMzm3f8zm
         ruyoHIDo6JQyLQGXnwRhr/leJ4r2DUoHMmMMp1yaUTZ1ztFGEAodZwUYqJhcx1xaTitm
         KvSW/qILWVoCh1VEyPJxoPNDUX89jxXUD5iL7o7iFsAw1psnKkTeneB1jpw3O+OnFi7l
         FzONsp8dpe3NzWlKr/Jhj1FBCDqV8FyeAPwbk/BqPZRmF/1t7oQ2HudlD1pkLHn4Qe8m
         qGWA==
X-Gm-Message-State: AOJu0YyxHfohvYL80CE4Al6j0a64OKdKKsNzlYfA4CJ/n5Dd45q2KX7/
	XSfiyEXsExQvazHHLsVFwwgep0CIrkMDe2EpnqjFN59JKOmd3DmSQVBOMfR2Skakr95els7T3mU
	tbfqy0yHen9/gd7r556iaEcV+nT8KTiGG6/QS6/aObiNZdOl4bXhMR0bM
X-Google-Smtp-Source: AGHT+IFjOiEUaCL94CuFQq9J6BI44OPOCKEvHn3xt1ya/xbLy6EdtInnIQX5t/zJeVdKzgKnyJl9bmSoGRyL6Zn3aek=
X-Received: by 2002:a25:8183:0:b0:df7:9762:ba42 with SMTP id
 3f1490d57ef6-df79762bf78mr4464681276.31.1716816354985; Mon, 27 May 2024
 06:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-6-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:25:43 +0200
Message-ID: <CACRpkdZMxwg8_FywDHZHMQYMeZ1Ly7aQnqb3ONbqiDAa3YzqHQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] misc: eeprom_93xx46: Remove ->prepare() and
 ->finish() customisation
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Currently there is only one way how chip is prepared and unprepared
> for an operation. Drop unnecessary customisation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Classic upfront design. Good patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

