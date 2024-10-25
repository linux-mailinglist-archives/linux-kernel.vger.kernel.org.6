Return-Path: <linux-kernel+bounces-381329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC39AFDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A0D1C2123F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE281CF295;
	Fri, 25 Oct 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFvGhKIZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03E1D0E08
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847250; cv=none; b=Nmf69uZpdEeQ/lfP1IrUQ/QoHoo0mV/mIXUM/FCCAYJTlsIDTPNX0fa5NMJttvZf44efE880MM5CLoycilvVzHW0DEXVqLxquhUvDA3bxkuJ+sMe1DMamDGgbGBclm6aTgM3aCPY8aG8s6UoUR/QI+wcjIRnOdR2Hi5uPnCymI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847250; c=relaxed/simple;
	bh=MjaRFk1Boxo8P6hdY50yu0DYYNPmnQY1ff3H1sDc0B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfU4ZoSobix5ar5Xq/k9M6d4CwC409w5Kn0xIxjJggXjS7wBAh6SGlpU1j+aEf3VMBx52vIZ/7VgMPyJ6KvYSoeq2EB+1x185MlK08bURl78tvHUmIwVgjCjoSjoM4IcGQewFIjRbnp8pUbVGUnK6qmPU/sT8GkYaOyyt8x3xY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFvGhKIZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729847247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjaRFk1Boxo8P6hdY50yu0DYYNPmnQY1ff3H1sDc0B0=;
	b=AFvGhKIZwH6cKClzVkSRzM7XsZrc2S4bvSOQPj9XJDNSuXTcey8eOJlDLkW1ESdAcyUEVB
	epYzqO9ilv7cmH3GxHuB1tvxW4bRfoPz/X8NAY+uAHnQ/DrmbZX29JFOZETpDISSn8S53R
	vL2yR0nZp7pX0XhSUpfKNWRXJ6VUPfo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Feo64nSpONmcnWQjE0tPeg-1; Fri, 25 Oct 2024 05:07:25 -0400
X-MC-Unique: Feo64nSpONmcnWQjE0tPeg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e6d31b3bdso2781322b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847245; x=1730452045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjaRFk1Boxo8P6hdY50yu0DYYNPmnQY1ff3H1sDc0B0=;
        b=s2L11rXG7/gB7YIBcJVl+F4K8AWpjzdl5Vd+swHP5GcpGXylFFpqvEnsj8D0sONaBh
         43SRBE97gnq3yJk9E2ouivtOdMoJ/s96BTCm7L6CkDDXyyXgrOoXBxdFZxle1zSlZLkU
         JSHKZFgmF7J7OlDZxKt196Cr8+99q7mR6Zz4TfkBBTCz02mvTQp9J5Kjzp5aS48dmk5d
         1PSl9zcZiBpbKeGNunpxUmyDrprM0QWXrSlJBx8HdXoGP1Nh9ymp8zJLQ+lt/61T2reX
         I8CWG7WN1ynt/35+TaD063dogMNMbL/uGtrWla9TNpPWKGoze0GJupjWHcc1yYWZtupM
         +Tkg==
X-Forwarded-Encrypted: i=1; AJvYcCWj8lcHviBf62SSmpUybjSgHDk2ZAlCvMo1me2mT/SlQUGzFX6Zpi2yI6jleI1dM9JuWApq5nwA2v0gYa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9SRevcIZhG0ZV/gZPHv1640Bfs8jnOtr0i0jiPY9UoZn529U3
	QcGCdRfeod3pWdqEDlcvPjevZVGQMu5mcCOmJ5goSMyAHK4nIQdHz8MyyPbjjTN6koc2x3j0V45
	sEi4eC7PHMgDV/A+AloYBWNNfW7zjKoKSGd7hI5p1W+76OCb2HFc8Hyswe3dONckanguDv+8xYv
	/e85JFpo/ZQP530i24Y8suLESbj0Rwsbz/ROru
X-Received: by 2002:a05:6a20:d526:b0:1d9:1fac:7257 with SMTP id adf61e73a8af0-1d978bae453mr9708027637.32.1729847244761;
        Fri, 25 Oct 2024 02:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzm9XIV+b509V+3GLeghUV+i/VsJ2ey2JtmN7aeUp/k8VVTwMbhlUV4fpMutg66Dalz6b6Cf67HYDB5jwMFio=
X-Received: by 2002:a05:6a20:d526:b0:1d9:1fac:7257 with SMTP id
 adf61e73a8af0-1d978bae453mr9708013637.32.1729847244384; Fri, 25 Oct 2024
 02:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013033233.65026-1-huangwenyu1998@gmail.com>
In-Reply-To: <20241013033233.65026-1-huangwenyu1998@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 17:07:13 +0800
Message-ID: <CACGkMEuMANCHFSCHCPtcQ4L-qT0uz+B7bWL8gxT46Fyj18fVMQ@mail.gmail.com>
Subject: Re: [PATCH v4] virtio: Make vring_new_virtqueue support for packed vring
To: huangwenyu1998@gmail.com
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, sgarzare@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 11:32=E2=80=AFAM <huangwenyu1998@gmail.com> wrote:
>
> From: Wenyu Huang <huangwenyu1998@gmail.com>
>
> It used for testing in tools/virtio/vringh_test.c.
> If vring_new_virtqueue supports packed vring, we can add support for
> packed vring to vringh and test it.
>
> Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


