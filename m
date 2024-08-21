Return-Path: <linux-kernel+bounces-296235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE43095A806
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDD81C21963
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821E17C7BF;
	Wed, 21 Aug 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jk9GE3Sn"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808F176ADA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281493; cv=none; b=NeAe2rbJF5Pm8Lez2ThO4zVIpiXwIFnVGRDLVQSPZlT10yHng5ocI/cG0SRZgy6JfKF64+tZqtk8ls4r7U4Q3RthUESgVf5vFYXPlPt/i8UtRPN6CYxA0XZFIxUrgpQf0CM9CiicToivxW9g4GrdowcvWeeHRgK5dv1bcUjj0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281493; c=relaxed/simple;
	bh=GJDNSAt1cuq2r8IoJd4PodaJixWuh12VF9JsHEBLnWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/6GnkPAQzudmJR9dpooKZN79iMdM83mFacUPE8D/Gm1AYnS0r3qVKwFdZlidQURYLT+GuakCRRpjw5ZNmX8Ku9vgT2t+JVk4J1WeTGN49MSOTuH8XngggwGw6xXoxzl3UWFmRY+dIcKt44jLsGNWy2d66Nh5FRe0DVDbMDWqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jk9GE3Sn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45029af1408so58191cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724281491; x=1724886291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJDNSAt1cuq2r8IoJd4PodaJixWuh12VF9JsHEBLnWU=;
        b=jk9GE3SnFF5uMUbbFuvAzam/GdH28zfOKokTeiwMZPBVnc7nnBEYaYjBTCP3N8I2r8
         by863YUezMjaAsoUie/jrNsQWFsHU96ECQlfoBRTKCXhpLCuROtKdQKQKHnXZQjNMenc
         90bUb6DfnFDeLrxp1GfadT0Vnb6Ve/FO7arS2IauhLt56eEDjpnFc3j6lnKM71IorKgm
         IwsmKKwMJfFx3Ki7m/hXz3yY0pqedsIduxGkTYEnX5N4Hq80sTOGL7u9yQBOG8dXiPAJ
         Zxw5hlCLIqPkJcWTzglJi4TnBqkWO+gjV/yFkR3mdQSvlSbPxtb50gLJqhtPO7gpHv9f
         cAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281491; x=1724886291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJDNSAt1cuq2r8IoJd4PodaJixWuh12VF9JsHEBLnWU=;
        b=MFMaG9aBdJ63ro/fYUISyCJ9v12jiiXz5TyGDyaHV+SQe7XDye+BFujCEuJwiR398a
         kCSbRYU6rZ1Vpf3hqd9m4SAfS9dGNxq5oyLWrBrKvLs0TsIuERI63lq4ap45MCzmLd4v
         7fg+MIsJg3p2VmzYdpWiqHlSPTteH0OBqW2VeN173QA5k34YipX3XRPT2biszvN8spB0
         Xy8RhC6jQN4/FVHOPEmOFHLQ+aaZOODpG3uZTQnI36HBqI/zW58R9efFApY39Fvc8wWy
         E2dpYuLQZTfnD6cAt1cBORWowtsSik+Ql6DHXebklXac9C/mAwjpP+WyoOcO4Jju0Bu7
         eUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc6Lyp+SR4xq6uEjJzfyZ7VaiUFhQ2Q+z3TXnJ6/V+Uh1bZ+KnoQFNahLonwAvnKOOjHGcNBhrETMTNUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwAzjOkh0EMtra+3cirYstzLCsax2qcQdW/2kD8ReoAKsJihV
	A4s6NfLWbP7FsbuQ4F4gyNaOyCHFHYZ8Fgx+U+Duv/CaHyyPyJ6YQZGWGwpCbPgZv3sjHRJrqQN
	ykUJfnlnDEW6fTJKeIOsIBoooqJKBdVMp3z+m
X-Google-Smtp-Source: AGHT+IHmPa8pxLjrhVQLkC0yK2VEkXUspddO+C6x2tTzxUsPkltMol2I8t/oFwFehRGi9Lm7bXiwfHkQ11nVaIA64J4=
X-Received: by 2002:a05:622a:4cd:b0:44f:9e0f:bc41 with SMTP id
 d75a77b69052e-454fd7a0bc8mr539491cf.27.1724281490717; Wed, 21 Aug 2024
 16:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821174021.2371547-1-mcgrof@kernel.org>
In-Reply-To: <20240821174021.2371547-1-mcgrof@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 21 Aug 2024 16:04:14 -0700
Message-ID: <CABCJKudNN=-4oXm8XboaKrMJ3U6ZF6kAUgDBwqEk+89Rc0EtVQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: scale modules with more reviewers
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	petr.pavlu@suse.com, da.gomez@samsung.com, kris.van.hees@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:40=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> We're looking to add Rust module support, and I don't speak
> Rust yet. The compromise was reached that in order to scale we'd
> get volunteers committed from the Rust community willing to review
> both Rust and C code for modules so we can ensure we get proper
> reviews for both parts of the code and so that we can scale.
>
> Add those who have stepped up to help.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Sami Tolvanen <samitolvanen@google.com>

Sami

