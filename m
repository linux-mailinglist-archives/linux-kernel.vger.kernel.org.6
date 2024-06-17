Return-Path: <linux-kernel+bounces-217191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5790ACBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C331C21DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FF194A7E;
	Mon, 17 Jun 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf9Rg0NA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC0193097;
	Mon, 17 Jun 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623108; cv=none; b=QDTkSYiONx4LwqxLyN0DlPYkAuH0q3E+h5Ke8RuBhlukuLluNqYRg0VXiHVKZHLZd+w977Qu5kI6uU19MMAxFTt+rx9CQyBoCleh3ATUAwrsErMpY4dmnSZcKU6yHfQoAmE0/lplxKACPIcDoJhD34KwQ5R5nmd2AM9O41P75lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623108; c=relaxed/simple;
	bh=EnUOtqRW29t4LY2qt3y9GCg8lgyd3zktbbs8wjcm+f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdNK2lOuE1iIsH9zRlt8q6VOteVtbFbZVXDFuLE9H3h6DvlkC7r51Nuqo0TGiVMlyq5+7TewOwp1uIIwMjIob7zHrJyIL8BHH8FKGlFXTDfnv4Ji3q+wdHaGedBJ9z5NV0aprpVMTyEGbMycURqTrB5CRntLbrBN0lxYwERvvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf9Rg0NA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f177b78dcso541607466b.1;
        Mon, 17 Jun 2024 04:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718623105; x=1719227905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnUOtqRW29t4LY2qt3y9GCg8lgyd3zktbbs8wjcm+f4=;
        b=nf9Rg0NAcIMLK7zS+/M+ra5s15qijzIcoeLPIHaPxqU7m7QjxBFHl/eiOnWpJmqeO9
         bxEaL15dbfveZp0C9ak8NUpWkgKlCyMFTNnA66alcGQ73u5RVEGsF1iUplFslC06/9Db
         DqeFhMDGE1bYGoAC45wL+hbmuenlUl4ji68eiQDw8JwsU/cV1NsULDwPb/MdlmBLKD6U
         3RJqsc3S2kSx/pG4Y7FScN/2HENz2WzDQDbZe9DfgG0rUC+TV6ySoS+lMPl0REgPHh/o
         VoDaeW3yotXokiAkRzTYfFeJcDpcO2a9AUFgxFlIfRs+3PbFFHe6t1BwgrXkgPuH8rMw
         G1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718623105; x=1719227905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnUOtqRW29t4LY2qt3y9GCg8lgyd3zktbbs8wjcm+f4=;
        b=VIF7PqcIIScpPC51XEGNQva9shv0RZzUPdEyL3LT2tHcDLAkmI2kzA1AzjLSn0hH9G
         l+x+FHW7V1qfo8gVgQe9AN5S0856X9ju7ZUtZJ6PtdXR7ZNV20eu5V5afyJ4kXJnUYzu
         cdqmuvXDlcRhiGCTeTmXM7lgXMWcOI16ktnHwsthO+1RW91eznzhHnwqKmOJKexm2s7g
         5164ixkHpGs+4i08iPnevE57P4QCdvDARkd4M+2oGrPZDLoizRj+ZYDXPjPeOUkgdJ6I
         YToq43qTSEVFUdAuL0E42vUNtkP5dCTw74fMpiYlANW8msxw2UtrbKjYniS7mXlBBjVi
         tRlA==
X-Forwarded-Encrypted: i=1; AJvYcCUHQHaInl9CnE1I4wrlOmNAgMT5fN2c9L5n+vnG/539dEjPSqaj21XiIU043mIslDpGnk97iagc9ouoWWk+u73ifWrL1YvXioJdKOOxpUEja0mCY2LNw54KeSsI30numVOzDs0ja8z9r7hLL3r/mq2c+hWXPZOnueMZSP0bijcwAtibMZQ8
X-Gm-Message-State: AOJu0YzjFcV8hwFUpuv/MBpqPccGdj5dbmZIVwi9HMxmigYs4Vgdjglq
	Ih1baybUPz2nkKAOGWsP1ZlXVhsihc9frF5p3RaCZZ5HwbnU+hMqZde8QFrH5fIOoSJg0eUWItx
	so8kbSV0nc2Vlb6pHToCwfvahxRw=
X-Google-Smtp-Source: AGHT+IF2kQT/PUg0w255bAgZSNWec9bhJXjEfsoEAMf+GB6lxhyXYDWaLu7E+tMPDQE3orQFLrRyjLwpODfZOCuk8L8=
X-Received: by 2002:a17:907:c283:b0:a6f:709e:523e with SMTP id
 a640c23a62f3a-a6f709e53dcmr472493666b.50.1718623104554; Mon, 17 Jun 2024
 04:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614033812.51312-1-animeshagarwal28@gmail.com> <b214c9db-fd82-4d5f-9cc2-96857da1bef5@kernel.org>
In-Reply-To: <b214c9db-fd82-4d5f-9cc2-96857da1bef5@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 17 Jun 2024 14:18:12 +0300
Message-ID: <CAEnQRZBPv+OAmNBHe8fWziw8zJKFkH8vd-oe_G-e3OVSX_sTRQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ASoC: dt-bindings: Convert realtek CODEC bindings to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:32=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 14/06/2024 05:38, Animesh Agarwal wrote:
> > Hey all,
> > This patch series converts two of the thirteen realtek audio codec
> > bindings which are still in txt format to DT schema. I have chosen
> > these bindings as they have in tree DTS files.
>
> ... and the point of DTS is?
>
> To validate the DTS against bindings and see if they match.
>
> You received such feedback already.

Hi Krzysztof,

I'm afraid I don't understand your comment here.

Animesh is saying that we are now looking only on bindings that are
actually used in the dts files.

We are no longer converting .txt files which have bindings not used in
dts files.

