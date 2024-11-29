Return-Path: <linux-kernel+bounces-425302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68439DC03B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B245162C22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D5158858;
	Fri, 29 Nov 2024 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DgZSLo6f"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10145C14
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867581; cv=none; b=i4eyeIgGjWMQRHHSk3OWLtBx7SPS58IJ6axai6qg7UOTdxi/eDgAbo6TSl3kT6pFJ0Mtw7v3UJl/OyGsf6bXo7NDkKjeVmWuSYY9QYnbvuC457bAsuzy0sCjHcZZs/uegnRKIg1ZuJF7QHDSQQ9P36RKvkMsCyoHkAULbB1/AT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867581; c=relaxed/simple;
	bh=xdCc7So5WJlPDQV9tqtG5m+9pg/vhfSFOA4sIRrWx7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeg1WeIhi1qRiPeFcYwIJNeJkwe2wgT0lXAdhKJ4nkU/SRM17X7D8FwHiCw1N4bYZ+SRutAa6oUBK5e0H4/klbW9R/MNaoA3JBGVMh0ZGU/vpNIyOlB9PduxR44nOBWc8tPKHztFEDv3adDvIlLc1fYVpsgrtPheazPmoimbGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DgZSLo6f; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa545dc7105so211088366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732867578; x=1733472378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdCc7So5WJlPDQV9tqtG5m+9pg/vhfSFOA4sIRrWx7g=;
        b=DgZSLo6finV0NMFXlYdFweErnW8qpOLo5kRxIkGgnIIZ8gcVF5bBoFT/efZRT8lUu7
         xL3d0kAWfjHsGfwba50cG6Tyh2h19ovvJuX6NCVsO8oTKmQ95lW4Ry4U60VG8kVeeLlP
         mo6aOBsr/rFDXZj2AxDc2kPGteNnXB2LshgLA4my56t88qqxKKnHvY0PgMCs62OxCf9e
         M7PvOsWEkpklDYlNba+zJiQ6824wPpQnTrg14OpBH3CqNff9sMT85OXvEM7S6C0txj4G
         2WjEMvHeIDsomS76u7ONQXlY7JQQf7MlzHCEwL53foo2gRJN9ncmehTQJDy0CaQKnUOw
         njJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732867578; x=1733472378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdCc7So5WJlPDQV9tqtG5m+9pg/vhfSFOA4sIRrWx7g=;
        b=rTNbWFVfLQYAb0/0hVWBKHV/2dME/omICkYXLYsBf3V2ADPgyvk4EMYV+l5Bq9TgIV
         XH48neKiQcP02Mwn1pfwasqvNe5YCigpqFHHM4V/CVekKQI+k0+gpAObU+leDqee+P6o
         Ngk9K7taDKNqPVH8FEc5YKYeNk9H9vKIYANDXCAa+QrPtyeh53qfIbyEqgUU/31HnLSH
         cTTW3QTscna9OquyQsuFUfRwXVUFlbIz5aJbHDeVwFwttaEZ7aYB/dl5xLar3apeu+rt
         /5SFSKkJAEGaQGuojDlvyU19Ae2jQ3IoJdftXkgu3kegZrSOWpguh0oI238oLZyBDFr5
         CXow==
X-Forwarded-Encrypted: i=1; AJvYcCVi3hap26aefo24tzePayII8/qGAr2zvYgjOwYUKNyLCXl9mcNbxj9cCKQz7ylxZdEiS/WsMowDpLY+eRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YystnDWzdgZUMYHAm8TBLBOdkt+Gone2NeMDbFLlZpltCjm141M
	G2zi2XhfK7aazFIKTFlWijPO0Dl1pdqUDIYBJp6aM4Hq3oqU6Y/5BWICge9WlcORqTS0BOQgQ+p
	05ko7LDSdpc4vU5g8Ci05tpYHXU9YjmXDDzz/s48d/XPGfkTFUds=
X-Gm-Gg: ASbGncsUwjMhkvRurVXyrfxIwrX3RcstOibgIL/Sppijlnlkw+lSgIFC8DnFtMebugx
	rWSn3lXEOGxuODjSJsSbsZQfCoE1FwKegNBOKXgHFE7DbKl4XeAIqWgU+64RH
X-Google-Smtp-Source: AGHT+IHvfYEqHD35f8UnLDugHPxFfBJiHJYV9810UXcLgYjqc2ISSIJrK1EXM5GwIAW4E5UPnf+3ZjJlrOLaI3o+G14=
X-Received: by 2002:a17:906:1baa:b0:aa5:cac:9571 with SMTP id
 a640c23a62f3a-aa580f4c51amr744110066b.28.1732867577853; Fri, 29 Nov 2024
 00:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com> <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
In-Reply-To: <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 09:06:07 +0100
Message-ID: <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> Pages are freed in `ceph_osdc_put_request`, trying to release them
> this way will end badly.

Is there anybody else who can explain this to me?
I believe Alex is wrong and my patch is correct, but maybe I'm missing
something.

