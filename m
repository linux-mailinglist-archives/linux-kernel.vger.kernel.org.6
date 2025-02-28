Return-Path: <linux-kernel+bounces-538390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CDA49812
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654861896559
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772D26136B;
	Fri, 28 Feb 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t50t4MAq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB24260A52
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740855; cv=none; b=HWQ0puCt8GIBlxAeTXcnfnnf0MnFAgkHNlX+mhn9z+uAysHNdC09nCKLtf9XqmfUXqy3MepLlsnoQ0IjbZNN69Olfp9I8uCOesE3f1CVJLa0DQOCj/EsHzikCFa1mX5+NPUPBrSWsGJj7+cy/2kobv3/oeOo4dmn7oz8c5GsN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740855; c=relaxed/simple;
	bh=7bO3noIAnLIpAAfMnWMpk9qr4QfTQwAh4WLgGAFGPng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6gPsNQU7qXpDaoHuUVFXJodraCVX7S3BaNJGDHhXvaBxb12oaj3PL7t2VXAXZwj1Zw1AHsbhmXEg7pcfOqSm0b8de2Fe243F1cgd23GdEPuMo0pgxRdAtDCCR48+Sndk34/ecAH8FfQZiBzyg7ET7o5A2GSAesYzx/SiFx81Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t50t4MAq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbdf897503so546923466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740740852; x=1741345652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bO3noIAnLIpAAfMnWMpk9qr4QfTQwAh4WLgGAFGPng=;
        b=t50t4MAqF9fEEHa+NyihLSzn9a92v/R+h6rjQRYfUqabwO4s9+rX5hoKfuItEi8Rjk
         p6IZvKjroqvAtdsBp+kFOxCAxxVzorGMPqAMez4udyvIJps90gRxmPFRFAu/RoouAJZd
         8+O1WPrHHBjwVIu5R3p4yPbYatHhl47SiHeEJbnXtnwaZ4F3miCS0vF3f8eWe69lUYJl
         3jlEt29ITFYvJ6jN7eJTYefCcmM/IKwkF+kYEXq3t/WHXyw8G/Qqd4x70T2NPMcCgghb
         Tjlid18hKOBTtPd3e0pKnK6/XloPsjf8IBk9liX0MQo/6ZXaiJV5nVu/pwu6z1zcswvz
         b8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740740852; x=1741345652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bO3noIAnLIpAAfMnWMpk9qr4QfTQwAh4WLgGAFGPng=;
        b=veN0zADA2dE+hqJivb6w68DG+RwXgPd8AUjEFrzAk7gRmMifXkJ2BjuK0XYbOJAsNC
         6nWPxXpjxdZvQh6ZmW0Z6MmVxX/3DiRLtv7pehUv0S6pRnjDJQL9p8f/aw42K3+nmEtz
         77oaNZxbu0X6C8VyurDgHUBX5QXtBRs2AW/INZ+3HxXBs9xqILWqJlaUdNBFK5aXwnKk
         Qol0/Mvh600nrJREc9TY2uhn1pyZz4gduttl3PwT7b9DpJ4G5rigVKJzzElukdBuVOR4
         Nl1pK5BL/E3bEbsklIaiLGFYGruTDsjQnfGRGX3xopKUaQuXbjZ0cW8wGL8Kb1hiiQlr
         m8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWaoWCulHwwb411OWPcBweFGgcD9PsMY6uqtSON7mzRrhRw4X9fxArFrd4I9/hQ3sZ/IuRiy9YnHLUuAmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuYD9n15Pb6RocLVZrFPzOqd1J9u2/IHb4L9k3s2fsMoi2x2w
	7S0yry7fZowpEXENJ7mQyWcj7VeEorKQR/3zqw6oLQv12mBbRF3eKV3eHBN17KTHMlg065kVZN5
	w+i19ROIabh3tr1EmeyPSCuY6fZ8+fKjmOdCHVyQUh00bSzDC
X-Gm-Gg: ASbGncsII6NY3ZdA+CxyTrI6xt9cFilQo+G0dzjx6wVnXbIsqF4ledrcQ57ISvcYXZg
	CnXKRMzH5GN9NYEu+YFSASfhkRpOlNHLzrElo+rYhVpEddZXLZEI/UzUdi4AXFPwZQ9Fri1XYgd
	F/QvQD0sM=
X-Google-Smtp-Source: AGHT+IE6y2PosJlmoE9B8+t4z8hZJxD//ouD+A0OiMkPbIArGuvY/3GdQ7UTMlpkbH6gYdu01DmaN4T7Kr+6onvynrE=
X-Received: by 2002:a17:907:7212:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-abf26430310mr261440866b.8.1740740852178; Fri, 28 Feb 2025
 03:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
 <Z4osWNCUfufciZNG@bogus> <20250228082745.rc2u5jiqnq7h737l@vireshk-i7> <Z8GAEDVIUiooPjf_@bogus>
In-Reply-To: <Z8GAEDVIUiooPjf_@bogus>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 28 Feb 2025 16:37:24 +0530
X-Gm-Features: AQ5f1JqpS5GfXKpRF9qd5JBXFvyQxz0hzQ3S-RWDwvb2fNYPEu0YQipblPVbjoY
Message-ID: <CAKohpomoY8uhqDMeUAa594Eh8Oh53hTSsjkAcJU7Z70asvzcSA@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_ffa: Set dma_mask for ffa devices
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Bill Mills <bill.mills@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 14:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Sorry I forgot to respond. I kept this out for now as we need to resolve
> the DT bindings.
>
> If you think it can be used/needed irrespective of how we resolve that
> issue ? If so, I can queue this.

Yes, this has nothing to do with the DT bindings and reserved-mem thing.

We can anyways map memory on need basis at runtime and this is required
for that to work. The reserved-mem thing only allows us to map everything in
advance.

--
Viresh

