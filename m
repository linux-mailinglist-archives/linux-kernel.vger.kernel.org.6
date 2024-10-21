Return-Path: <linux-kernel+bounces-373999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81C9A606E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF1B1F2245C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9B1E376B;
	Mon, 21 Oct 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOxgJQ81"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4D1E32A4;
	Mon, 21 Oct 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503805; cv=none; b=iZXB+0zoAf2AOEWvxc24aH5zU5TVtzeYVr6AZQvY1jP5fJ6GuBJI9HKxMcjQKEKFyiyaLASen6t8SNzKm4/8Wr6moeKCMOYjHQuSUKA1ve38rj1f2pV/S05NGJHkgug13P8g9ImzlIvPaLDJM5uLOa4Kce0E0xunuQagI6Xt4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503805; c=relaxed/simple;
	bh=WLQzzjkWn8BYyGnGkfYMIkyxT5MqPku5adLbUxRMOtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3khHft+WfQ+gPz5mDQvZJRm1NH6AsFivQRJapwJxBtbDv0QP/0a/CjJLIByOdKjCbGT8vQwjuaWhODh3ngYvNP/NJtd1wyZLhi0pPlyqZVbW8NGxgkGF4dUjzv2kRobCYGSUc206YMTu/Z5983te9mQrzqHthm0i8bv6zBIYow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOxgJQ81; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99e3b3a411so852152166b.0;
        Mon, 21 Oct 2024 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729503802; x=1730108602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLQzzjkWn8BYyGnGkfYMIkyxT5MqPku5adLbUxRMOtM=;
        b=kOxgJQ81OWrsN2zQI/ww4RlluBh18BgUInzJxQ+6qDg14ROLwMr6ahyrwufFpcO9W6
         mgsg9WVE2HQhaaumBujkAaMphOzxYdX0Zao3WZjNLxiaHcNytWE+AAOfDShU1sVPTyL+
         5mbHuvdH6tSzhFUV7GtgETpSh25pWQZ3Yt+FmjBGLoa5uv2V6K/DvQisPM9dRoX6cReA
         pi8ZFU1DjzWux6Tnx9LTNZ6m4wcGzVwmqHiGIN/kwF8cqu4fE+9i9FRrgXYp7VHvtBNv
         +ArHlafEve5eBHwpgVG7LGBKiRh/0vop9wD4Nay4nmIsGVBaxKo6Cv2FwGA6RvxUvY7A
         p7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503802; x=1730108602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLQzzjkWn8BYyGnGkfYMIkyxT5MqPku5adLbUxRMOtM=;
        b=OltAF5W06ka5kC15np/YwPxYJ5ju7Kxn2NTiKs8ZILV7+hYGyUixFB8bwOXENlR0p/
         bgj7VaOXFFki2/aETfkM9nvpjSGLSE7HR7DgbT8/6QuEnsZ5YV+PmVxaiI546xAiej4+
         DnUjD+dK+mqapem2et243l9GEskYNnMp396jQGz/cW+kgNInzfej/bJ/w/qVh172SViM
         +AP0seU8w8D6g4O0UK9m5Sf4/4sHV6gv6e7wfHilnCqswboD5mUJeXodiFVBjePdbqGQ
         1aa5i+vRKbIoj/2ogSX+9lv42VompFETCw8IR7Dw7H08XaJJrx/D+ZyRK31fJ5lGTGaG
         AmpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4YSe3Rifg0nArFHenNh0IuSKA3qheDI4KzIRBf7LUciuCsD1qWNDFnb1v4mcgaD7gLR0QrgXjvoN4Lvnal6xuYAmH9w==@vger.kernel.org, AJvYcCX/RItR3aeL4IAAisKk7yfdkYChq//jjGUM7Td6AAHQXOrDUGSNKqJtzDkd4tIqOfDD+FK/YQlmGuIzk7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiZ+V/25MiIagVfulRUNsIezrzR8DfTVvKchUn9DQyDkcC+05
	YG298qWV1MnsfwpeL4rEV8iQ4Faxv5Y6f0shaDzSIOyFkq7dZlMgt3j/0nwggbqt9SfO8oRa5tS
	QwOdyIUQqQtf7Ki3Hu9LGVW+QB+c=
X-Google-Smtp-Source: AGHT+IHWVoHZzx66vm5XItIOnhAzewmvpF+TDxqDaHLETrmpDx200z2cbbDSQykdfAm3Kt0JjcWib7PCldbNCMcX9hM=
X-Received: by 2002:a17:906:730b:b0:a99:d587:6046 with SMTP id
 a640c23a62f3a-a9a4cc58f60mr1402633566b.32.1729503801298; Mon, 21 Oct 2024
 02:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
 <20241021084053.2443545-3-andriy.shevchenko@linux.intel.com> <28078013-a643-af8e-22be-f36c75790ba5@linux.intel.com>
In-Reply-To: <28078013-a643-af8e-22be-f36c75790ba5@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 21 Oct 2024 12:42:45 +0300
Message-ID: <CAHp75VejavDObi4PMLPVCO==YCTRkOvV-uOOSyx_=74bOSrKxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: intel_scu_ipc: Simplify code with
 cleanup helpers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Ferry Toth <fntoth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:32=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 21 Oct 2024, Andy Shevchenko wrote:

...

> IMO, this change is doing too many things at once and it's hard to justif=
y
> why those changes must be kept in the same patch. If the guard() change
> is done first and only then the logic reversions, both patches would
> probably be near trivial to review for correctness.

Are you insisting on this?
Because that's how I have done similar changes in the past all over
the kernel, and IIRC you are the first one asking for this :-)

--=20
With Best Regards,
Andy Shevchenko

