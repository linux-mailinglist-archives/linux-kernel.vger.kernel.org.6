Return-Path: <linux-kernel+bounces-393171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC29B9CC6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 05:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6CD1C2138B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A75140E50;
	Sat,  2 Nov 2024 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2cGy4QuP"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D417F7
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730520883; cv=none; b=J9yje6d2VCWhbrZs9AeuU3aFiIPQrDxR8nN2WGgoilo2vRaucgxVHa1RJKZi/zRknsc3L5o37j5zRyAuq9HoFf8i0CDSP2LcS0NEtNWyyPTCrYWALQ8sS8xdLKXoRif8jaa4sUhR/MMAMyXMd4WqarHjQ4N7RIvguxYy5Z57nrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730520883; c=relaxed/simple;
	bh=ZhD0A6fFMQgetHxXaUqGCccl4RdLc+5B+f0TDv/tFb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex5jdKrIfx2xwi20t3E/Y1ZjuWaV79foIVXqFyk6QpTpMjulPTZ0H1lVaI1M5mKSxFkUXzbqNiUNt5VrTcM9J1W5qdkEuadufdh13N3CsBZOvgmjGLK2HHUMHY1qt1PoPCs3HTSjgXhxDAYy1hjzxZAjVJQIeEJk0PkrywpcmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2cGy4QuP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so2515112a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 21:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730520880; x=1731125680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhD0A6fFMQgetHxXaUqGCccl4RdLc+5B+f0TDv/tFb0=;
        b=2cGy4QuPB2OTwOayYfQKb9Gr7r2oBUxDUbkGdXe8PKm0RHCKmQvVPajlSny9uiAP3E
         qRg1wJhxWx9TKjBlq8UkcEprLLGQ0Ppa2mC1ebjQsdIQAXYksHOAZpLJpFhGte1x3UOf
         jK0NXPLiCBzFOUCkpsDxu/CxtsWIyFOZanGy2g6/7AaMQnKpOFqZRX2nQQ57yQLuuYgu
         sW6pO1hHVqXqjm0OPAx/+uRCW39y/+4rQhz9I0t5tORMwpZW15JxqvSe08J7dW07aXjz
         pMpHYlFE5ukI7UA31SeemUz2hd/QNfio0tfFZ4Rc8mHaO0o8fN+gUlfX50i0zjnR8aNJ
         pHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730520880; x=1731125680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhD0A6fFMQgetHxXaUqGCccl4RdLc+5B+f0TDv/tFb0=;
        b=ol1cO7vlDiuL6xIAUp7AFHzkHHebmFfRb1JBVUuXIXd9fZClNcKi2vQw8DegsLYm8G
         e9Jjz2K5kJIdvtpDK2KDLlI6r2yStG95uRqYvGySj14o21p/oQBZfkju4jEKXXd/Ikag
         YvB1S325q7MCliUQ82gqYdHYjl6kwFpLEnt2zW+qfWS4zL7JcmqvxlB2WKffrcsxNgLn
         tm0CJtvrs5Qz9cWqZMLWHlGLwUSYyCfTp1vAYbL3wW3sFY8fM5jbp2mGgSLJNXJ9Bnj7
         Z51Kbe1vrsGA8oEpqLKu8zbZ7CV37ta2Diey+x5kc643zN0qxx3H3D5q27gqKynZ/YzZ
         jQqA==
X-Gm-Message-State: AOJu0YwADuVD/OpMMnpu8ZUgk3UJ1T4GB/y0E7SfXRlA1nlRngKAdO0M
	eNzYXX+Xxzu+5nk8FTkOPzVF2QjcyubBMkGffuXGlw4pzeJz2R97cGLbgVyW/eEh4oA+0H48knA
	AoWAUBaoN3iihvduTA8lQTOZ1Icqj+PxmRXU=
X-Google-Smtp-Source: AGHT+IHd4My05K20F74U4VNXVkl89e2GMigufvzRDMaeQNOohx4FEt2r4OzlrMTKam0oJE5fnuYW1weqFjIUrGDrbj8=
X-Received: by 2002:a17:907:3f2a:b0:a9a:4cf:5cea with SMTP id
 a640c23a62f3a-a9e50cace53mr879565966b.54.1730520879481; Fri, 01 Nov 2024
 21:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031115448.978498636@linutronix.de> <20241031120328.536010148@linutronix.de>
In-Reply-To: <20241031120328.536010148@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Fri, 1 Nov 2024 21:14:28 -0700
Message-ID: <CANDhNCoDbRNq7miiU-oGnX0VBUbZ=sDpP4Ko6OYQye+A=Z5HAg@mail.gmail.com>
Subject: Re: [patch 1/2] timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:04=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Since 135225a363ae timekeeping_cycles_to_ns() handles large offsets which
> would lead to 64bit multiplication overflows correctly. It's also protect=
ed
> against negative motion of the clocksource unconditionally, which was
> exclusive to x86 before.
>
> timekeeping_advance() handles large offsets already correctly.
>
> That means the value of CONFIG_DEBUG_TIMEKEEPING which analyzed these cas=
es
> is very close to zero. Remove all of it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for doing this cleanup, Thomas!

Acked-by: John Stultz <jstultz@google.com>

