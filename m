Return-Path: <linux-kernel+bounces-310977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24296837E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9071C2225F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E41D1F7E;
	Mon,  2 Sep 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA7Yzl5h"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AD1D0DDE;
	Mon,  2 Sep 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270199; cv=none; b=tCxacNc/+JisWHDCvlRwPG+oP7wwVuruhgWp3dohC2Bb/CMjzBUFgGWBBR1ZRApM4gKOoDO238yBxUX9AbminKxQNvWp3g8IJZnx4/pp5Obl0XW5jnrVdML+rNXdHft2ekufY/BW2I/8UdKVr9o+6MAQZOWJt9F/Ci/XEaaXqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270199; c=relaxed/simple;
	bh=zhNulfH3n14fOn2JNuL8z+IAWX0T+nyB/inh1k7rzk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5kMUoUXIkt8UtUS6s0md3sJUSs2jzrHmPVmftS6qytkHn8uOwkhBOlQqTIj/cylbWvFxwEI4Qr4IR2eco7FLuwYK0lk3qlKtaDuXukk45MQaEpql3slMZMTHE0UpRnpo+oxUzgydw+c+44DkT6MTtJifIVuAbSo5+TtKU/6DLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA7Yzl5h; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71446767885so482786b3a.1;
        Mon, 02 Sep 2024 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725270197; x=1725874997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhNulfH3n14fOn2JNuL8z+IAWX0T+nyB/inh1k7rzk8=;
        b=WA7Yzl5hAY9dqH0twbDCZ+0em6+4x3DcjRHvC6YNG2mY+jVkojHIKknZAm0BqAjGO1
         2+gadKO9IiEJzY6PktLN9M5VHbs3xuZqgSDulM/ZEaNA7gEj1qeysoPRaGZO6Y73pFq3
         NSUYcnZpVIpSeTMZx8TktqfvMfSKYl/IVOdUHvs85DKqaarhu9iyc5gzCGARs04mSwwZ
         joWIlNIDeozaaQuFCbC8WIxKBeNF1j8Qr998zVF7SsVTT7v+ph1D1snd0JNLNy7El3kz
         5M6M0PhmjiizfmMcETwlsr2jNhsQy3ikeJHAqal2g4hA0dx3nO6KqqI954ANOqsiXFnw
         qJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270197; x=1725874997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhNulfH3n14fOn2JNuL8z+IAWX0T+nyB/inh1k7rzk8=;
        b=HepQMztuFkd2CqkJeroLl9RTdGKLK4xJBcfESytqiJiBMycLqDF7JOqVpxQCvegDul
         q4Ng3UYiAclgBiTg3qmF380DSiEUGFGVwUNmtL2/x+o7B9dt8sDs70aAmESDhswsNlB6
         zsMb2TPhr3XTIkSHFPdeSiueSFFajpMUVZAAfX0wR5EGTan2UF9nSOjHwWfGGbZa4agH
         HAb9RW59YZ4gsz3HGl8Ok9Vop4H1o35eAFIdcHIXLNo2TRBaZuvtjJhE2iOnTITC1wqq
         Kc8q6fd2Y7MsX+vlBwlcgfbZ8SPFQv+oP/6+bFyKCy/kg9GZrMCY+gsPNalKfBXP+e7O
         s0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX2PIIKMC8pjWFqIRQ17MnvQJc6YdIrxISEnDjOFhzzQLVxQ5cuR9JemkIwnm0apX8szQ7m96cia9Ai4Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzklVQAd3W6f/Cvh94vtlvto0OcEaRcYRhvuOUdUmflBlWLDt4Z
	Oi85CBZe64AyuinKYYMBiYOkUoy4oLJKwISmLhiUR0YYB5opKxaceutx07kVP+WGA/CLUl8UHkw
	w39LXOAfPcI+qpbhoaecj0iyBRN50mN8L
X-Google-Smtp-Source: AGHT+IGlB+lEw6yJBKm4oVc4gGZmqwkZTrNL4hcgi7QWLNM1GhPkqBPyaA47DL12j+P/wMgG1SA7SHZrN/XXeuPoenw=
X-Received: by 2002:a17:902:c409:b0:204:e4c9:ce9b with SMTP id
 d9443c01a7336-20527300e77mr55557025ad.2.1725270197468; Mon, 02 Sep 2024
 02:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828211117.9422-1-wedsonaf@gmail.com> <20240828211117.9422-2-wedsonaf@gmail.com>
In-Reply-To: <20240828211117.9422-2-wedsonaf@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Sep 2024 11:43:04 +0200
Message-ID: <CANiq72nv4Uq5GMVMrZ1pC971gCW9bjFPZsMcFRnLwp4BHrNNig@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Remove Wedson as Rust maintainer
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:11=E2=80=AFPM Wedson Almeida Filho
<wedsonaf@gmail.com> wrote:
>
> I am retiring from the project, so removing myself from MAINTAINERS as I =
won't
> have time to dedicate to it.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Applied, with sadness, to `rust-fixes`.

Cheers,
Miguel

