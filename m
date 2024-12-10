Return-Path: <linux-kernel+bounces-439343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79CA9EADEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0DB161EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE861DC9A1;
	Tue, 10 Dec 2024 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3TDEH+7"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7578F40
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826281; cv=none; b=GJFkwyO39q8WSo0UoloIlQeBcNq8tifuX+rSjXu3SLbDhDo2SWOdbKrj59FNybUPUsLX4FjUKksfv3FLncOna9RmojiuqO7LhwfzF5p7TdwikTUE9a43ucRJoPg83P8cvf5sW/d1WXJjFq9Tlxc7Lv58kGg7WVLwzm1euGzOGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826281; c=relaxed/simple;
	bh=KacdTMDwGHOubfAMUMEA0y3RYV/hoieH8eSRxF9Vy/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Psrv1JuhqFHdI5+vSKmLiLSVzqcz+zNcHPslusRURTcQgjEF5QB1ZgsIq1spptcwXu9Tpa8/7CbcfwngBoDmPkaRNX5da8nBtc+Zs1J1+axn56bfD0ufGHk6zMaw1PLmCFt1x+lIcS6HbEwp01kLcWprsVT05sp3YbErphUdVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3TDEH+7; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71df00181b2so999508a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733826278; x=1734431078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnxhJKvx9jYvossMLwXlm6WCMeoNqlxmsqhx0tMAQvc=;
        b=W3TDEH+7hUB3uOktZN2+rAjiIzsIwLe+nbUQCCdTKz617Ax7EZ/Y3eF+MSPcBXZ4Ho
         ePy9bnnabXq3LtLEEzZrhjJ5VtKelBWpnCR1BQIGToBAKPtbCxC/uvZfz9i0+ZHQPpb/
         Jy+gYdDntjUUVu2zkZoClfQukKNE+lt0HayX/a+sMioPmZ1bDlLooBJgut/7vUfEfJvW
         ov6QB3LbJrxszoUsTlLC+DjBamKy0eZ5axYBENbM+H/l3avG7DP+MUx2WJtt3eANoyhg
         g+OgETo/g1XgsujhdyYaUOI60pZkZ6wX15/9RWIPu2pwh3hi75W/N66hD0byPx4KN743
         gYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826278; x=1734431078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnxhJKvx9jYvossMLwXlm6WCMeoNqlxmsqhx0tMAQvc=;
        b=kOUolHwLFutCiUTDqagAFJyy2oHMyyUVUGaTyCZKb47SmOuVutf1OQqPQeyzO5ttZu
         pdMAkPpZrVt7L0SM7TVrDYZLvocfGaR/Bs9+JjDwVsrGWGPCR+P1bPMdPzT6/tf6oAdh
         uRB9NpMClmdtnY5vVo0id/awHq2EyRmFsjoOLNcDIAQrDsFPEslBlFknGzkDk68P9tb8
         hAW2v0UyELJSvhwmkmUEPiwYxlcDylFTyAQUFwH61hXTXmuh4dQ0bqKnhhzTjpq49jjM
         in+fNfbKwem6WXyei4d2hUpv2g3QLMjuOwToddjTuYUqPKAkmD3y4+sN5/QnTOsF3jQ9
         n51Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO9HW79BBGYKqhe0je+MoivMT4P1V8CT+7hnRoAqsvCsuXoRsKkXv7nAQjT2TnIYNd2jtQmxpVEGYL8U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9IBHzB/3jhlDVb5+mGX8dxW4I4d74UfixZM8v8gxE+6TfpvP
	NKoKGK7xgU6cfrNu8+d2tcbFJRgU4BH17yQlKdijvtAJxkEojQQHkU8Bul2aTbcyAxG9rTT0Lxo
	XOMShFUhpFSdCa44wGLN8dJcH06NtIFb/8+5upw==
X-Gm-Gg: ASbGnctXa2+TB2FtdutHCcOzMaQBBp6Tr5QlpJjEjGlzAvpktClaL9yAszZLaEQDzLI
	ALBBMhh9vCFo83atbg357CjJvF9w0InCoxyqx
X-Google-Smtp-Source: AGHT+IFqSNy/U675xZEjsmCHP/7RnRexS72dnpn/UvAKcfve/GQogygTf20YsSMYxyFib0NlWI+JrNXv9DbPSym+qsU=
X-Received: by 2002:a9d:7d99:0:b0:71d:eee3:fd27 with SMTP id
 46e09a7af769-71deee3fe91mr4254214a34.1.1733826278464; Tue, 10 Dec 2024
 02:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com>
 <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-5-f502ef01e016@quicinc.com>
In-Reply-To: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-5-f502ef01e016@quicinc.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 10 Dec 2024 11:24:27 +0100
Message-ID: <CAHUa44FhZc1ZVgJQrqbDdY1kegNgHrC4VTs66-5CDfY04D6MMw@mail.gmail.com>
Subject: Re: [PATCH 05/10] qcomtee: implement object invoke support
To: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:20=E2=80=AFAM Amirreza Zarrabi
<quic_azarrabi@quicinc.com> wrote:
>
> Introduce qcom_tee_object, which represents an object in both QTEE and
> the kernel. QTEE clients can invoke an instance of qcom_tee_object to
> access QTEE services. If this invocation produces a new object in QTEE,
> an instance of qcom_tee_object will be returned.
>
> Similarly, QTEE can request services from the kernel by issuing a callbac=
k
> request, which invokes an instance of qcom_tee_object in the kernel.
> Any subsystem that exposes a service to QTEE should allocate and initiali=
ze
> an instance of qcom_tee_object with a dispatcher callback that is called
> when the object is invoked.
>
> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> ---
>  drivers/tee/Kconfig                    |   1 +
>  drivers/tee/Makefile                   |   1 +
>  drivers/tee/qcomtee/Kconfig            |  10 +
>  drivers/tee/qcomtee/Makefile           |   6 +
>  drivers/tee/qcomtee/async.c            | 153 ++++++
>  drivers/tee/qcomtee/core.c             | 928 +++++++++++++++++++++++++++=
++++++
>  drivers/tee/qcomtee/qcom_scm.c         |  36 ++
>  drivers/tee/qcomtee/qcomtee_msg.h      | 217 ++++++++
>  drivers/tee/qcomtee/qcomtee_private.h  |  47 ++
>  drivers/tee/qcomtee/release.c          |  66 +++
>  include/linux/firmware/qcom/qcom_tee.h | 284 ++++++++++
>  11 files changed, 1749 insertions(+)
>
[snip]

> +/**
> + * DOC: Overview
> + *
> + * qcom_tee_object provides object ref-counting, id allocation for objec=
ts hosted in
> + * REE, and necessary message marshaling for Qualcomm TEE (QTEE).
> + *
> + * To invoke an object in QTEE, user calls qcom_tee_object_do_invoke() w=
hile passing
> + * an instance of &struct qcom_tee_object and the requested operation + =
arguments.
> + *
> + * After the boot, QTEE provides a static object %ROOT_QCOM_TEE_OBJECT (=
type of
> + * %QCOM_TEE_OBJECT_TYPE_ROOT). The root object is invoked to pass user'=
s credentials and
> + * obtain other instances of &struct qcom_tee_object (type of %QCOM_TEE_=
OBJECT_TYPE_TEE)
> + * that represents services and TAs in QTEE, see &enum qcom_tee_object_t=
ype.
> + *
> + * The object received from QTEE are refcounted. So the owner of these o=
bjects can
> + * issue qcom_tee_object_get(), to increase the refcount, and pass objec=
ts to other
> + * clients, or issue qcom_tee_object_put() to decrease the refcount, and=
 releasing
> + * the resources in QTEE.
> + *
> + * REE can host services accessible to QTEE. A driver should embed an in=
stance of
> + * &struct qcom_tee_object in the struct it wants to export to QTEE (it =
is called
> + * callback object). It issues qcom_tee_object_user_init() to set the di=
spatch()
> + * operation for the callback object and set its type to %QCOM_TEE_OBJEC=
T_TYPE_CB_OBJECT.
> + *
> + * core.c holds an object table for callback objects. An object id is as=
signed
> + * to each callback object which is an index to the object table. QTEE u=
ses these ids
> + * to reference or invoke callback objects.
> + *
> + * If QTEE invoke a callback object in REE, the dispatch() operation is =
called in the
> + * context of thread that called qcom_tee_object_do_invoke(), originally=
.
> + */
> +
> +/**
> + * enum qcom_tee_object_typ - Object types.
> + * @QCOM_TEE_OBJECT_TYPE_TEE: object hosted on QTEE.
> + * @QCOM_TEE_OBJECT_TYPE_CB_OBJECT: object hosted on REE.
> + * @QCOM_TEE_OBJECT_TYPE_ROOT: 'primordial' object.
> + * @QCOM_TEE_OBJECT_TYPE_NULL: NULL object.
> + *
> + * Primordial object is used for bootstrapping the IPC connection betwee=
n a REE
> + * and QTEE. It is invoked by REE when it wants to get a 'client env'.
> + */
> +enum qcom_tee_object_type {
> +       QCOM_TEE_OBJECT_TYPE_TEE,
> +       QCOM_TEE_OBJECT_TYPE_CB_OBJECT,

The second OBJECT seems redundant. How about QCOM_TEE_OBJECT_TYPE_CB
or QCOM_TEE_OBJECT_TYPE_CALLBACK instead?

> +       QCOM_TEE_OBJECT_TYPE_ROOT,
> +       QCOM_TEE_OBJECT_TYPE_NULL,
> +};
[snip]

Cheers,
Jens

