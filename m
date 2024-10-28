Return-Path: <linux-kernel+bounces-385663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2F9B3A19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581081C222A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D31F4275;
	Mon, 28 Oct 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozx9gN64"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB21EF92A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142426; cv=none; b=EV8X0Tlkmj92VprBo34XYPsKVWLxk668UXNhTQmAn5zRM1pp+n8m6dM7kvbuyptc87HAcAxTnqRTyoNGmpVTmIXw2xakWejCHTFnDrgnBE9qRUlJgcrUJ5ooGOkIAmNJxBY7K+cpPAPYqUEHDGa+OrplEvD3J67hDg1BcMTMpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142426; c=relaxed/simple;
	bh=CYf5dukjn7rDDYhHwSQdHTT50BMvVU0WfA2tdldI+h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Km8Zw0/nJDg5qemDde3r+CezLZkVWg6OH6AnrRL5NbFf2UmiQUcjMuh/9z1Km9nVRP5vmSjxd5wx37nxOOqjv5MeGXSW58k8sPAwL/Q2vMvcrIEHKVBD7OBI//nFctgDhwCGk3fVpTCyIqrVDZBD6NhXWO7CEugCYK4b0zAVmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ozx9gN64; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea0b25695dso9617077b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730142423; x=1730747223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CYf5dukjn7rDDYhHwSQdHTT50BMvVU0WfA2tdldI+h4=;
        b=ozx9gN640695WWtDYCSZjqgLXgKNbNCkz6q+zCS1mms1zN5fkBCEbUnWxh8rENts0k
         Rz2pQRjy5b6u+vnWClovv6Ax/DnTEde3zw72CL+Fn7LtOcRJo1P4Xe0041ap3K1kK5xp
         SVdk5LWM6nXVxbTQtM/srbpsT7YeyhIkupUtyv/we7s3CepFQlTbS1Adb6T9oiurXRXh
         GEZBkzm3O9IuIqYwrDVb6iEW53L9uzrg99vFcJVRPISCVTKfghA7RS41vyuEwG6gF5yO
         t/NjXqeK3Jqdjs9UOOkceDAcGP/w41oLFtx+QxT1Vhg7lazGtzM61rkwMLzOcKuzu3K2
         49yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142423; x=1730747223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYf5dukjn7rDDYhHwSQdHTT50BMvVU0WfA2tdldI+h4=;
        b=ldT71E4y+QYZBpJQ4bDV+p1TLJdZvWTuYCAgH4ZCvZz15ZyIwvhUbG8XMX9ZtCAG8s
         ZUASCqWYMfNSaHBAWi9AqTxvU1H9WTZjFD7fKVf7LquzGFZG3VGnCL7qbs3OikNT+RgD
         LcfZA2jKGSlA2YHVg7j7qc6gvfu9QCjlm9sjJgxUhLBNTR+d6e+xDT2HGOrpS1BopXY2
         LxuwlqD+3AkbA2EKkbgi7UjVIFnTBbm3vRs17LAFtK7SA8Wskp8v1Nc+JPg0BWW4OVr8
         ORLN0crynEQBy2WoMiTi3+mfTbAvOeew26n9TTo/ohBq+nTMcIoKwbQGtr+V+33vBshv
         qeeA==
X-Forwarded-Encrypted: i=1; AJvYcCXI/H8bvcBvK8c9wxZUf0Trg7N3fa2cjyxbqjU+Fz4mihCUVYIvdZVCWzDdbP4PEq4NDcV6QGyjZ3GVMic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZjJF5Ern6+4EbAQwzqmnSH0uQu9N5maxCwUlSpNDBLj3Wapd
	WswVdUCjh89xvubCcHn2Dj9lKvxMjFDCbxqub4W9lvxpI7l5Kxsr3pKLmNpmY1PHuI0TlWB+G8O
	EsBwIkXEUAkChcsGSwswwE/i1p41ZjNVzffhLqw==
X-Google-Smtp-Source: AGHT+IHyHPH/y2spfAtTOPC7T4/oktX0c7cDb2FO73u0b8ET9iUIHaq8J4lMT8osQnwjZSJWs+VfpVu7MgFNNvKiMpE=
X-Received: by 2002:a05:690c:d81:b0:6e2:636:d9ba with SMTP id
 00721157ae682-6e9d88e827fmr76513207b3.3.1730142423400; Mon, 28 Oct 2024
 12:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028083030.26351-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20241028083030.26351-1-lukas.bulwahn@redhat.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 28 Oct 2024 20:06:52 +0100
Message-ID: <CACMJSeu32-cnn01WoLbv4ffbMt3CfF0MTqbkxZHvu+4HQio=Mw@mail.gmail.com>
Subject: Re: [PATCH] media: remove dead TI wl128x FM radio driver
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 09:30, Lukas Bulwahn <lbulwahn@redhat.com> wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 78fe66360ed6 ("misc: ti-st: st_kim: remove the driver") deletes the
> ti-st driver and its corresponding config option TI_ST.
>
> With that deletion, the Texas Instruments WL128x FM Radio driver is now
> dead as well. Delete this obsolete driver.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Amen!

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

