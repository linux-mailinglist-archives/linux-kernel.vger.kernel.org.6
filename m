Return-Path: <linux-kernel+bounces-428063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20959E09AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671A32827C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAF1D9A6E;
	Mon,  2 Dec 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NrjEcDPE"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EF1D86F1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159984; cv=none; b=tY+oYaSPlI/a6+J5f+IsHOrKPPTQe19t8dexH8AwSp58vPMfiFYxIQTnOLFKmTUqBSCWMRpPEftpyoABHPj+dlfTOoRNiefqJjjCwOLUAeM8cGJxQvmqgZezzHgCgg918AXMV8+JlCWMwWrDRMg0vpIZ/r+mZ+8RSGfEGv4glhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159984; c=relaxed/simple;
	bh=2ctuogoSjK0o/YcAhghDTTPG/7KuJAbOS60FWyTsnzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgnKfISoTl3cWljnLtsj5QOV6rm+DWRmy/WNDVEWM98j499wWRstAa+wSYAS+FcNrTe1yIjNEcxmz+nr99H3Aspa/nKH1X2KPvGrwmniRkbhN4UT5NOumH3K22xcuUHtXDzhsmftCPUAuamLEhkvbWnPU7gRsJkvmrBkS4NAIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NrjEcDPE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so45117881fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733159980; x=1733764780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCHSl/XvHU0p3x8PterARxlRewFe3slvbHsWITVnfoI=;
        b=NrjEcDPECSE4FhRRxb+E6YnqNLQIbZB8KPn3gCe+Chgl4ySDYmSQKdwBqZUjhDgZPX
         8CV0/E2ZjCTM6KvWd8rvlm1LttAkl+aPRCXReyjjoyc/8BruXv71Q+ioJOk9FZGodSi1
         KPPu82YJXy87MwSNc6s4svVRB0h2Hshg7fMxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159980; x=1733764780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCHSl/XvHU0p3x8PterARxlRewFe3slvbHsWITVnfoI=;
        b=FH8sM7tQZ6Z/IKQGJfB0PBd2iP7JDUHAMxhdWt6tgrC1rUOjpWd2OgRrxPAY2ipkke
         iGIKJmPqsXJXeZseq4Zi4jUAM9X8NYPz1Q9JRg+o47eQhJ9cheb0j3kKJXXM53xfnWrd
         pXoFH2gldK9eoWMpwH+EenlyvuDgwbDsp+/7/OjXr+oBjdPTzsfd/S5LQCPYEMIUGHaF
         QBL9o1f8LkxizUe31SrdaNzYwTA3zssJmzRrnQVLMxZNp6e1wp32LHknTJnADfhYQXhR
         sXCdXUr9199n9O2ZY+TpA9dwrHv2zqC/bY1X7jO6rsnl/lOSqaqI/OIbN90s6gHSBVs2
         vXrg==
X-Forwarded-Encrypted: i=1; AJvYcCWBHS5oxadS0PyHZtgJPuN/YxKttBvhBhcdHrGc1dJygG8gRACvmY4um9IK3m1ru2UisVSZMgrjJdiDOW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4Ef5TdWdbsDfXAwzTgnsOWQJPJmfbRkI5DdkyDzXfcEDOgDh
	cyJcAOLl57qm92kVMQjg9vslEkGPYAb+AGGLD3+MrDA9BMW7iDhXHDh3OTuZNqViKili5wD5LzO
	ByQ==
X-Gm-Gg: ASbGncu4RoZ+QJVNV0IeB8uF8MS+HqQq9sikuD8AKzijsTqzu8vJ6JfgecqdfFrKkQI
	gFqMuE4KANnsjVKrhJ5hoO6I/J+y2KsZ5kRdsfCD5j75+aKjF3cc0VYIrwSQ3MtstRJsCN0stoF
	JZwQJKH0xltWv4sS6yR3DUJyKniLm7M5cSB9cdpO4uuQZVQwcJDE9JeJQtZrKKzxFQkssWObScQ
	hYYaJBtDDizwoxlsWjhFYhdpfLGcDZTfg/ZgMo+3KuYfnKoQ7uiLUtzpxQ9cgIP0lXVwJPgWKss
	RLkDy5P5Zcecdw==
X-Google-Smtp-Source: AGHT+IE6hunfa+yknYgE+pPSdzt4vgDN+r+HRVKLkumDR5I6jLDkN3hDububdTNRYZ8AvcN9Lmkoxw==
X-Received: by 2002:a05:651c:220d:b0:2fb:570a:496e with SMTP id 38308e7fff4ca-2ffd5ffd33cmr82825331fa.9.1733159979779;
        Mon, 02 Dec 2024 09:19:39 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc745b6sm13509701fa.74.2024.12.02.09.19.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:19:38 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de6b7da14so4522454e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:19:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfuM53pvE3RA4MtPP+mqlaDR4ZGq80y2Erh4DWyMUduCtsCaYH/QaMlDKYxLvKPxtei8w016V36HZzsww=@vger.kernel.org
X-Received: by 2002:a05:6512:3c99:b0:53d:ed89:d78d with SMTP id
 2adb3069b0e04-53df00c6433mr9076074e87.5.1733159977423; Mon, 02 Dec 2024
 09:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128203542.GA370417@lichtman.org>
In-Reply-To: <20241128203542.GA370417@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 2 Dec 2024 09:19:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XO6dvRHvu0tn=Vb6Eb4B4R-1rXA-==9vY-euZwyk7T_w@mail.gmail.com>
Message-ID: <CAD=FV=XO6dvRHvu0tn=Vb6Eb4B4R-1rXA-==9vY-euZwyk7T_w@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: utilize more readable control characters macro in
 kdb io
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, danielt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 28, 2024 at 12:35=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wr=
ote:
>
> Continuing the previous refactor in kdb_keyboard.c of adding the CTRL
> macro, this patch moves the macro to a common header and utilizes this
> pattern in kdb_io.c as well, resulting in more readable code.
>
> I have added the _KEY suffix to make the macro more clear, considering
> it is now common.
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>
> v2: Refactor another line CTRL+I line I missed in v1 and remove CTRL+K/U
> I accidentaly included in v1.
>
>  kernel/debug/kdb/kdb_io.c       | 38 ++++++++++++++++-----------------
>  kernel/debug/kdb/kdb_keyboard.c | 34 ++++++++++++++---------------
>  kernel/debug/kdb/kdb_private.h  |  2 ++
>  3 files changed, 37 insertions(+), 37 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

