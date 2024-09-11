Return-Path: <linux-kernel+bounces-325584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89110975BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD461F23781
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E11BB68E;
	Wed, 11 Sep 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEfvoARy"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447A1B9B58
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086443; cv=none; b=JcWRUaXz0YI7qvTsUx8Fg67KVMxiZeHUx9ZIU+lquoEgKx6/vnXpfBSlshRZ8FZa78nEinyD09NpSpjkinjRQVDIJ/7OL8dEHglio6PrxvpPKN7zXkPE7z2kIfuoN2h8uzPohLpkm1MNkNHP7ZOUWZHzWT6nmg9EJVEi9QL/zl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086443; c=relaxed/simple;
	bh=usQB6eg6mpIjrsouU/6sUW2LWu5N/XOscjT9iNplmEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n97zNEHxzH2SWb+LTCM7NAT7XhYybABvWdBVuEAaTFFGGLKYaLar9jJ2Wt3GtieyO92IpseG8AZNG+cEKS5fk9aVsHwq9TRVt7kS8Fd2oIYdXQzGqkUbZ/JRcF2aNUlZNvrXcCQywvT/eSgim4UzQNFMnwRDpaaK2AtgGh73+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEfvoARy; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365a9574b6so304901e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086440; x=1726691240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usQB6eg6mpIjrsouU/6sUW2LWu5N/XOscjT9iNplmEo=;
        b=YEfvoARyWSQ3LozHIRtsuSCZbRcDqLuHPpYK0CnEHBOACmLm4qSdM3bOT8ZZRndG/e
         NgGspu/x3ym85FPBXT0kNtdq6cHunvEzERWMILpBEUV8CCi4zI2fuJRdExq5oIPrfl6P
         5vJpp2HR91ZJZ/rhj7/mLH8h3jQLcvchCgbutIYL32h0sEJJqihab32CoMhtRRQZiMuV
         dHsdC64xeWYf6cA5bN8QcBbIQXNr/oyR4fIlElCULLXNPAWvp8NIndp+1nF1Cow0ZN89
         tBkrFj0l4AfK5mbqGQvRFJ56/9PXpzyX5YV0j64e5lh6t/Rwl9lP1TGm/5RtIAHl5x3L
         XhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086440; x=1726691240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usQB6eg6mpIjrsouU/6sUW2LWu5N/XOscjT9iNplmEo=;
        b=wEy1S5QfFqgj1xNyftcAx9VBt48wr4G/4hIShiCrcpcvaoCtlZoJzcwfqZ/3/M9jWd
         EDYE5GNDVHwTf+5BFd/0Ut1ZnUdCQZ0Le9KY5hRtlf/eHE4BkhhWghPRRAOKQO3ZrOQ7
         ELHA0oMvOxU3yzr1sFXRlbWWWCrle9wDH5iPvN4AAjCIGTFfKpu5iuzVItxSJnnBFgWg
         k3oY77T/Rgj6E3RwWR5ypHpNrbM53lDzpavy5cpGuegVyE6TskMQCYmSwACNngOCRMLX
         W8gZoZsg9JYVqAsIQXl7/P/FKwfOQYR9xhWVOF89vTZuiGIN5llenYSAWDn5xpUtgCXp
         yx7w==
X-Forwarded-Encrypted: i=1; AJvYcCVbdnzVnxcmtC8KZJmUPcSmXWt9Nh44jFza8kH78hnzEfKRw14c5B9n5+Pon8y/iBEAUIUYA9WD0xKNpRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPuxpx6IYsicWLVz5Iw3PmgPoXPZA0cHHnifdMRhkuJY/f6SJ0
	93hnXwJJhOfQ+9H2lIuAsEw1WdD1poIyHwqTvjBixlhT+vFZwGsvM7G3NVgrJHG8COW3wBxm9RR
	rVQneBMKLJ9QQqVtZsqUmqZdJRuHk0NDnJR0=
X-Google-Smtp-Source: AGHT+IG4PlV5COBYM0Q2Nd2Q2wDM/W9ZwRGrJE/N0l3sWkn7WmQMK2BHy4vlP8e6y/RG0l80VfT0klkI72P4nGw8EEE=
X-Received: by 2002:a05:6512:318e:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-53678fab4a8mr420583e87.5.1726086439266; Wed, 11 Sep 2024
 13:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:27:07 -0700
Message-ID: <CANDhNCrNpLWEbBmx=6a5i6HVtCe4FXrJG9RsY_ak3gi5-1eHPw@mail.gmail.com>
Subject: Re: [PATCH 10/21] ntp: Move time_offset/constant into ntp_data
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

Same optional suggestion on dropping the time_ prefix, otherwise:

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

