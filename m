Return-Path: <linux-kernel+bounces-383557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9CB9B1D46
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142A1B21249
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022481442F4;
	Sun, 27 Oct 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWUgM56X"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15C757F3;
	Sun, 27 Oct 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730026376; cv=none; b=PsF2hSppv6w3MMm/emI0jVlNS9+FJkMNkFrNzLd+z2aEdibH1dLPAbsPAiYvZh/TJ/ZJBwRZZu0MfSHs9+zQ23RbiNEckeVVxVddrnitVpdY2GNmuEium4JJvAe100IUjHE8d/THje/s5kVJII8IZU92ASjauNVvTHzMkboUW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730026376; c=relaxed/simple;
	bh=6sVFpo0V6Vop0FE3IzxQYQEwW/nt2ulhkh4IfOARj3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J56FdaLgC+ao3+YQ9IaOWfCssgqppD1t2am/AcBfDYYtzAWYOtCaWUGBm+P4Ih56q+uNN9XcIYxkJ9hmJD0n5iIppSf7dxlki36WIEjzjYF8ppanPnx9EaiNJjxoQWOtz10Dh0t6Eh7P2sRNVwvdJHb/c4B+d0PZcLoAuc7/mJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWUgM56X; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso2334209a91.2;
        Sun, 27 Oct 2024 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730026374; x=1730631174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6sVFpo0V6Vop0FE3IzxQYQEwW/nt2ulhkh4IfOARj3s=;
        b=bWUgM56XkfM/+FU+wustLyd+fbSW44o7UK70vr8KFMNr47mwfPLYmca1A8VSFChtYU
         xv1q9ykDm5wv5yw3s1RMhPCfivqcsVQ1EAsKtaUDAM7MLxBycgvRaA7cnwpwSgmRoFfm
         Xn8Hda55h9p6V8BSZ97yp/KATYweiAuEvi33piWTc7rCz6I6K11FULmBUSHcTb59oqn1
         juO0q2IJoyge5rZuJbsGH8KOjpGQlrm1kPHk9SKdYds7nftmNk4zw8uwAaFJI22Arq8r
         y4EdhW331jM92TJJ9RvhmnFY3zlXXdEoLgN82sfDIAe5sHJLBufeohpgXl0VrSD9XmKW
         Mp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730026374; x=1730631174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sVFpo0V6Vop0FE3IzxQYQEwW/nt2ulhkh4IfOARj3s=;
        b=LSCIsd8XvxptazVY7FT0qIm/LMP3Q0R/cNLIwZdnYVTDj28ViCs1lv6p0+6HGP2YgW
         a3tTXStV54h2pdpntDCpZeXo15fkC7g46bPZ91m/jMe6xfk1/LCzQ0fmmQZOP/qmAlLy
         KCC3toVyMBLGc4kBXyK5TaWB+gGQA6awceYdkRnGH03UAm0rKHxOStOwH7XI1CaFfCQs
         XmSs6RIduoUtFAeg4M7VdFECtSrdSlbjwCCTMg5Of2EuowvFj4KC91upHq9HIr4anx/q
         EeqXIYxAebmJUcmCH7BQnoPiuzAHYHjxlkcC/4rs735r89xkb8slAjgTsiUYraKVYDhY
         sqgw==
X-Forwarded-Encrypted: i=1; AJvYcCWAGDj6CSKEqJxk/xyBRoIESFxvcBCHi3M+khWT/crf+tA2riS/UFhQKYHw72TBVmEDmLzWOCVP6oBFgEli@vger.kernel.org, AJvYcCWJCY0yJqnQFdsj5HYp80Ek23YsX+Tx8i1ckNBr0v+BDAS0yoQbEIeU7gKZOPWG2Dk1tUTlIy/JEVnX@vger.kernel.org, AJvYcCWNaSVMY0yzlFSwJN+YAwvhEuuW/Jhro3GYuZ3wHvUwWKLaH+TElpXexSjTpVpILd4uWqkvTxFNSfag3js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLkN/wRZS002DYoC3q7TcVelJ/n60gOAGVG3hDxjvwj+NhlIM
	/gmuQhp6i9W8XFhSu39WNILa4ZpIA/CTv0pc+l8HKAkuKg7YPRw6U7LfzOp4hSapcxC5whJ9aom
	cxjYw3BIrqcVJq0/hg7Cj8WDfE80=
X-Google-Smtp-Source: AGHT+IFpFeki+BmfQHXN18aCSw4DRjutH2CCTHlzsmRMyGhTeocbRcRd226PavOSFnEnfKIDtWtFRQwbeAj8hmnQdBs=
X-Received: by 2002:a17:90a:17aa:b0:2e5:5ab5:ba52 with SMTP id
 98e67ed59e1d1-2e8f1086262mr6060988a91.20.1730026373921; Sun, 27 Oct 2024
 03:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026-add-ltc2971-v1-0-109ec21687bc@gmail.com>
 <20241026-add-ltc2971-v1-1-109ec21687bc@gmail.com> <495cff30-b472-4903-b1b1-e28349061ef9@roeck-us.net>
In-Reply-To: <495cff30-b472-4903-b1b1-e28349061ef9@roeck-us.net>
From: Patryk <pbiel7@gmail.com>
Date: Sun, 27 Oct 2024 11:52:42 +0100
Message-ID: <CA+DkFDZmK=YGDWbK7BPZg2TwCQ7p_BYFDSaa0SSEZ=s3hmYU2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hwmon: pmbus: Add support for ltc2971
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
> Unless I misunderstand the datasheet, the voltage resolution should be 1/1024V
> or 976 uV, and there should be 65,536 voltages. This is from the chip datasheet,
> PMBus Command Description, Note 1: Data Formats, for L16 data.
I really screwed up, I took 4500 (N_ADC 4.5 mV) from datasheet from
ADC characteristics section and mistakenly interpreted it as the
voltage resolution. Should've spent more time on this, please
disregard this patch series and I apologize for the hassle.

Best regards,
Patryk

