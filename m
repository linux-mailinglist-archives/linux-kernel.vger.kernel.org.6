Return-Path: <linux-kernel+bounces-537511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E05A48CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7FF1887914
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642B5276D1F;
	Thu, 27 Feb 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sR5ay0+J"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06945276D15
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699072; cv=none; b=iCmxThSC5SAiuO7e7vZlKuF0Eaw25rorKjhpKMxSAGn5Gs5AqucKqCroj31du6Hn9gYq3vYtZOrO3Ou5bfJMUIRUFNNDiWo2HamuzLUj5j6J23qzzzVtSdyZfGLe7/OqtRrMjUDZlrgwjnvpXUIVhCux06BhzUDbhmqLxnqifNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699072; c=relaxed/simple;
	bh=IaHRDLSMhNHQ5jw1EyNdC2cl6TQcuWJ21bMzGALrB1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trheBEsJ94ukdO0mim/G++RvtnpgOJerXAbESCvxyW2cMPy0prtLUoMUWV/+LjvVXo2pskvMRau8VD4YmD/6VJchngnX+X2opTcaGYz+9V4tr+saMlcHBgsoqAn+HjLqmWd0743rd1MNkoexn8yOIaZSpBBAiQZArxQ4Z7UGyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sR5ay0+J; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54843052bcdso1312448e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740699069; x=1741303869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaHRDLSMhNHQ5jw1EyNdC2cl6TQcuWJ21bMzGALrB1A=;
        b=sR5ay0+JNhvbBswcLqMse/f7aDgpyDtkeBkz9Gr99AMVIdjsI+3PliB01LPn3KaaWf
         kdnQYZhZnkKcK1yv1DyyRjTS19xkSfYrhx13AxT/8eLlt+jcx7n7A2U/5F14CyJWCXOV
         MLXpiHcSYBuuPGqJ4Zcb8XyDnaxuvgmGRZLTPfnydR1Eo7DQLa/gozaIXOfJPloPLlMq
         3mpI66s6i/i/IMr59C1ilJHWfdLVE1fju46LPjTLEihpPVnKtkczXPvyknj41dgNIJ3n
         C2V/QXCEqVMwLmYfCcYBCq5cdVwYLRdWAodVKaCDsQIXeLm69zINTkBOat8Ijlp63LKg
         9V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699069; x=1741303869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaHRDLSMhNHQ5jw1EyNdC2cl6TQcuWJ21bMzGALrB1A=;
        b=piooaUZ3eVt1NHXOk/2cwPjtDQqQ7EslLMRx9jQmvG+jmaYIL91yShXAV0Yw4RdnVZ
         Mf2iMn3Ax43a/AXozKGjeESVK1jzWVrojAcffgcL+7D6JymiY5jI0qi0O7nH26Y9pTk8
         Puj0ODHWuAfsYBYV2XnOfAHcfvROA5NIP+xkO6LLmWOkdOKHgy5jPGof8nU/6cXQQXtR
         Ga25nkVy52yTqJBOrZxrjj1bPFWeIfd2r6tef9WMK29hwUZ5fSAIdxJF0j1jT7tXt85/
         dF81a6vFM4F6xoCXv4AVnjapXrLDYaSx2z3NaM/ToeRbzUf/LuJW/W3OG1VfLNdAFdyO
         xQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJHLk+QRCcnxmx+xvem5BgO+eQ8+exKkYusqNH5uMOWe5SZGLtK0mgnCJ90Mi8lpNSEYjfEiSSgj/yMRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYrXoLWLQSCIRwFTOUC7ixqth17wppIXtXAqNwWvn2+s3CYnJ
	ncrmxByxZ+bFOiP77x9Mgp9ipVc8PdQumcdvSTULd7KG2/08nXCZJIJzgo6eUWAIrkEAEDisOZ4
	g1WKUEDQoWm/00NUxsBfpPeSrX5PcIBNfHmYDuw==
X-Gm-Gg: ASbGnctU/4aCE4zQMbrpcVhjHFb3wY7gH6pwqpZQFJG3JHSbdkX7eIoIzD9Y/hM4xPg
	T9vkjFNxehaq7QzF9qff362lu0p4W+Nr+np8IKZfgqrb2WorUFzLBIP4+ZKRPaHVaFcl7v5t2Du
	1o+N9DOiU=
X-Google-Smtp-Source: AGHT+IGGbs1UVyEgAcakRDFXIeGYBdUxdhWfag9rAL0rT+OgOPNIr+4bssP7UEerjkTRNMc7dyVEUpBQezVs8eLvUok=
X-Received: by 2002:a05:6512:398e:b0:548:91f6:4328 with SMTP id
 2adb3069b0e04-5494c11b516mr580710e87.15.1740699069023; Thu, 27 Feb 2025
 15:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220155036.2734838-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250220155036.2734838-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:30:58 +0100
X-Gm-Features: AQ5f1JpjkmaOs8rnxPzvRgfLNG60MoCpF2hC66NOqkW8z94ycu4HgaelFf-UG3c
Message-ID: <CACRpkdY1tgHQyU+s8HxfW=rK8bFfFsbz=Pa4EukOrNvC++4=0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: wpcm450: Switch to use
 for_each_gpiochip_node() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Switch the code to use for_each_gpiochip_node() helper.
>
> While at it, correct header inclusion as device property APIs
> are provided in property.h.
>
> Reviewed-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij

