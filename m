Return-Path: <linux-kernel+bounces-328693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B994978775
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003761F24521
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF0126C01;
	Fri, 13 Sep 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPBntywq"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39784839EB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250587; cv=none; b=Xyc1xvly0JZwcMtpmaD8gs2a2qW3gG72DUorK/+KnjENRnEmtDVINJTYv2gw0WCjvOcigmbmGt1gAWFSMJSrrYth0WzvxyANE2N6eSDwQXQTz2zv9xBEzTaGn8b4GQCLmGENbHErEH7KlwSu84nlA3NdNY8PHF1WpIFPUbVKnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250587; c=relaxed/simple;
	bh=UXOkfh0KcTju6djH7sIVB89zq8vPdKXMJhkLDkEvaUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiZ5RjBCd8D17tpUHaB2WYB4Nx0AT6u5s8nk4We2R0T0jjchcLqq4cJDFRBC8OPxJf/9Kserim6HYYqZoRel4XdclzSwK1waTUieO8FbSDTWNydY2XSjb5hUwjQtuBV+8ayIzYhKV4/cq1OajJwfIP7e+Ol0bNm6i9ZxJ4WEhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPBntywq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-710fe5c3b44so707807a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726250585; x=1726855385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXOkfh0KcTju6djH7sIVB89zq8vPdKXMJhkLDkEvaUs=;
        b=FPBntywqsxArJi54K4PxjZdCs2Y8HU3hhwmDaz2q429m9R25ERQP0zx3BkqV72gsms
         UEhE0VAbKfw01LT9oL2yLHKxoIm7dL36ArSNSkX0KNtPaOlTCBwtpjUQrBVNPIk0R3ph
         +0SkOkOTAYnUGx8YyAkpH9bKioiU6yqRKNvQZjaQ+lDbldo4kzsQ33OdaepJn5hwr9+j
         W0xbTcAH/H/9Bp5q7Omdv4eW0ZTnwupdhkhKr1tMTMpqmlf7J2z5SwAfwRLawC9xvnY1
         4PtRMu13rg4gx1SWVokPOopH2N3AtgfbFAn3/tpKb8Xeri80N8qcrhMhYN+FEMKRX6+z
         aAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726250585; x=1726855385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXOkfh0KcTju6djH7sIVB89zq8vPdKXMJhkLDkEvaUs=;
        b=MjFz+5Cifwh+Sor+kkQShGNTJ7KZKWJcsxEZVfIFcL0yXVgUveroHqBxVu6PrHxdCK
         vlmYMMlaDzMKnZsjnM6/oqwg3ibx5+HablYnSNvsHbeT49DtSmakP5yJQWda0t9C8Wkj
         bkPBP8dn/9uiJH0ubYEAy8QIERjgenEUYMScUMstL2ei8VVOcg4QDnJ64Pcegl4Egjyh
         igkLcNxpJHG7TUiSUIjn/qhvbFvbGRf7IzK6Wdru/fIqtU6Y4Aj/xVHJSUFdSFmouwez
         UoTNJbYoWeIq267E8blhXjGRzflnKZmvG9Of+lpZ9OPK6gYQGj2EHnOma4vV1zJUDkNK
         lGag==
X-Forwarded-Encrypted: i=1; AJvYcCXZV3rZo4lVK4CkM/WwN3bz/wMvgK/cLcatHpM8238LxVwb93M4D6xPUDYx6kXCX4/Ww+L3RD93Pmyj/lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KDBrSWL0/RcEnioacPLkQUz0IBYhECAQ5Uh5D8pozx1ki/tO
	QMnvsBdjBOTua73NRWVNVYUaURRIxVmHAvUub23Rq+cx+BTPiX3gBNBO1RvFLvS+/y5IDBYra2u
	ksUxBYPO/L5BORlCrYfUqXdt4oFkzqQNxQDjo
X-Google-Smtp-Source: AGHT+IFrf2QUiZsdEKs4/Sf36WYr8jWjIM29ElW6cJcACEnzKBzgpfdB7Kxl5d/I2hCYcFryV9WuyJMJ0IY43uIBeDQ=
X-Received: by 2002:a05:6358:3a06:b0:1b8:6074:b4e with SMTP id
 e5c5f4694b2df-1bc394937d8mr183875455d.9.1726250584950; Fri, 13 Sep 2024
 11:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906005803.1824339-1-royluo@google.com> <20240907005829.ldaspnspaegq5m4t@synopsys.com>
In-Reply-To: <20240907005829.ldaspnspaegq5m4t@synopsys.com>
From: Roy Luo <royluo@google.com>
Date: Fri, 13 Sep 2024 11:02:27 -0700
Message-ID: <CA+zupgxMefawABGDkpRy9XmWJ5S50H1U9AF9V3UqX2b5G3pj-Q@mail.gmail.com>
Subject: Re: [PATCH v1] usb: dwc3: re-enable runtime PM after failed resume
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "badhri@google.com" <badhri@google.com>, 
	"frank.wang@rock-chips.com" <frank.wang@rock-chips.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:58=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
>
> On Fri, Sep 06, 2024, Roy Luo wrote:
> > When dwc3_resume_common() returns an error, runtime pm is left in
> > disabled state in dwc3_resume(). The next dwc3_suspend_common()
>
> What issue did you see when dwc3_suspend_common is not skipped?

Apologies for the delayed response.

To answer your question, if dwc3_suspend_common() isn't skipped, it
can lead to issues because dwc->dev is already in a suspended state.
This could mean its parent devices (like the power domain or glue
driver) are also suspended and may have released resources that dwc
requires.
Consequently, calling dwc3_suspend_common() in this situation could
result in attempts to access unclocked or unpowered registers.

Regards,
Roy Luo

