Return-Path: <linux-kernel+bounces-325594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8BA975BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51977287ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E310B1509AF;
	Wed, 11 Sep 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCmmK6Mk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E3149003
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087017; cv=none; b=FD1zKwwHfLQk5iLha2dr5g2AaRGqNOiKm3NXR14ehfkscvfkPwE/kMetFeViOZOcuEmpI2g8WpjuFiiYJd3yqjRaGjMLljqDfpogC4R7yszBVQ2Z6XrT0U48EteiEd/7/t3RY5lZLoSZv45u80pqtl63nD6rmqAPq9CUYGH1o4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087017; c=relaxed/simple;
	bh=Uw9yAXR8rk4p9Ffamo+FQ8Lvj3P8KR87sahb6gOn9js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUKTGHeLPiYRHsrdaRjkGgkIYuuSDd3XS4Wp5VI7LHunn0OqJG+S8V+aUBGjAdwQlcU9DBtTXjq1L4nIvOnb3xWtjDQK7RsCHmPhlIIq5tBOVHQDJWkbO+74si2UP4nOzoUpYQszM2mqa23WKzSwwMayazsjeoY7F3C7heY3MhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCmmK6Mk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so29619066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087014; x=1726691814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw9yAXR8rk4p9Ffamo+FQ8Lvj3P8KR87sahb6gOn9js=;
        b=uCmmK6Mkgqqr+cDYCM9EtiXzngEgUgjzDne9WsRHG0jUSycpJ1P95ZsD50HOxWMrgH
         fgHIxBe6dKn0Bv6G/Oc3PAf6279ARTg9Ejpu6SRCttBqMsaLyOqW4P8sWeC7r/4tRogP
         5mUAIq4HdZT1cp8EEZXRvs4r3dKO3xS1JYq/iUPA204v3O9RR9lbwRifZoCa12IdQniQ
         +y99/QrzjadlvVPdonc6z4dzD7+VbZ0eS+8xbNrrYsRMX/NKfDFJYJELIGuhgDDa8xmC
         gZc26BozrONm0mblumOSgRxqO9bASr/EvRUYkvgFU/wzZCOpvzPyiDq/7hy/FNeaygbl
         Ul1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087014; x=1726691814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw9yAXR8rk4p9Ffamo+FQ8Lvj3P8KR87sahb6gOn9js=;
        b=eAhxT8x2cDkfNeV8ewQbtm0QngxdTCuU9PZA+XARiuja6vxOIe3K2HgJ7wO2DHNpbV
         cUlezkrEZUsB03oHYu7QvSvFqMJjeP6MCknRmg8dRcYQvf5S3tz9r4okghvR+uGxYxyD
         S1pxWrf4qmz7j5E66tBpkOtUCvCPxyhKiB9xaF9ruLdotcQCucVaOqWu6IXFOOVncxz5
         9nRg5ztgmz3yjA2VgJek7QlzziQ1+J9FiKuwVO13RBYz8W8nNLwlg8GjxVQS99XDBgRp
         8vNE9MotgFrrv+b63gordmoHRlcNLQdP19e0gjucIdvh0XD8gJvkW1wHuehZO4Qp72zi
         ebag==
X-Forwarded-Encrypted: i=1; AJvYcCVvN/lg2jANVRDYY58dxWkMhoJgcrSoPgcfBsig8KXa3M/0D9ygh276Z2jiJll8bPtvbR9QaWK9iZ21fcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbFSK9Mdq8lPx1mh4oP1dtQ0YCgyEdl2RvdbyTShlfUdcorXS
	Gn8Ud7XZzv82RzV7rfu6nZYtW+6p+tk5hCrzgngmwIAGSsqa2eK1k5l6ut885zRBzG0nf1yBiJ4
	vEn8tNy/lqKV9aE51fSaN2ibEEarnwIEsT/E=
X-Google-Smtp-Source: AGHT+IFlRA/31VVjyLO6IgPZgimZuNZEpPlP6ku769FDbIwcGpgPhwzV47lU293LtufUhrwsWjhHkWk8LifM+eC1/3o=
X-Received: by 2002:a17:906:f592:b0:a8d:3705:4101 with SMTP id
 a640c23a62f3a-a90294cdcc7mr55683966b.39.1726087013614; Wed, 11 Sep 2024
 13:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:36:41 -0700
Message-ID: <CANDhNCqoaK0o_8Us2BgDb7DjEU-f3YmXE6iOA+SBqX8o_jSfRw@mail.gmail.com>
Subject: Re: [PATCH 13/21] ntp: Move time_adj/ntp_tick_adj into ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Continue the conversion from static variables to struct based data.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Running out of steam to review them all closely, but they look sane
and simple, so for the rest of this set:
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

