Return-Path: <linux-kernel+bounces-250387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7F92F73F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B32B2241A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D779142645;
	Fri, 12 Jul 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoIGoh7/"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269385C56
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774386; cv=none; b=Ol3XgxtL1dmTsFo9dlzxFSVUTqsivLuVhcioAG3BtyAZJb6QZI7zxMxKxYgute7m76HSNIOMe38DmVEOF0rgQTqEgFCWUvFnAB7VcoOLW/QQKwusFAaPRvomyyrF66el6/m5wLWvYkK4iT4cnCHjRSgnb5oyfvjLlAtz1h6/XG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774386; c=relaxed/simple;
	bh=ERln6ANfm4V3FgCRBQwskodZpiUliJusdGPv9KO0N7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjjKzc1j0bZx2DxO/xkGQP219Qg72VNEAhgfsEbTz+LSgq1g+Uge2encZT+AQghTkVpefKiLbgJIUMZsbjJY66NlgHN49xl/0iZytZxcm9Bw1Oidm3n6mAZ8sJZLuG8jN0ywitmU2sQc39GhMd9+yUalDx6r9JpZdeVPrqOFyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoIGoh7/; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c46c8b0defso937522eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720774384; x=1721379184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDeEBNsECTEzDJAMZtRgJ6mOC8T74qNfEAw7Y4fVc5A=;
        b=IoIGoh7/9qR/U28sWOoNyYDSDmGuZzlLRiiakrJ7QgzTO5YEKhEUPPHyQmwyn7WaES
         RYPyvRBzliHhXMNA3U25vCCScR8sDSqzIO+DNx/YRaeb5JI1yUZTpiT27thsJWYyLnOm
         +CjdcsBiTbIo2VWeKzj0LE5NbUyZVxfhhEijJEYhmQqqjLJrhnOtTicJiSpoVdjfOoGs
         1mS9AZYpzXEN0Zw8gpMHv5GljQ52KPMQGOoj/mzg6mB7kiKVLPMebsHoT8iqD3iq/3aH
         lmOp9DdGg6P/vDJ+FFEn++sNxeMs/QS25iISzN1oPlbQq5ClNkxfRTsIiZmGl43vEWm+
         LA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720774384; x=1721379184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDeEBNsECTEzDJAMZtRgJ6mOC8T74qNfEAw7Y4fVc5A=;
        b=lwa1e1pW8OrDQT0qDEZji3bUbdTJfhQ4LgcjCPs/LsKvaIjc7zjOJ7HyYFTO0LGVRj
         538+HpMCAQJ5B8aLF55I272xDNvl1T2H4inenHraRB9ze1zhO+ySH96vJ5ouzsgBNpDh
         ubHRSNwDvlpVl9CIMBqr/pk1LfP12xp16OKacpIHD+CEoMPnX+qi7aVPYjUAssNWhVHc
         P+D5JjFEek9lBGP/UMvHiRmrAGD5KezgRuIykMCvWx2zziMQ4CX7Qt4sls8fxBR/eKJW
         dV7cDs+iMRMt18OjsuWkdsRjDqTsyfFURTZS3k8N8n1uYIHC9PCfHaJiYD9kpiJbMD5v
         f3/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNs1n/mskWNO6yDOrIbM3J9EFMAcOnJ2qN7/ksF5Bo7rcdLt92Dpf1py7a6pxvHadBmp8RUcKJPIFWGBD1sZkXz3gZblrD3cJz+EJs
X-Gm-Message-State: AOJu0Yy5ZrAr1JpaUZr3JOkjFJMvWdrOD1o/A9z4LxGcJ8hQtDEoyknJ
	LpU1yrM0O7QvBzXpBKXRp32G+kiwk3McEznI835m+jK3z85bBwD6fRUEoNqArNoslhFqier54HY
	t37bURuhz9E+2g0r/OCN5lL7Ex8KFQV6t
X-Google-Smtp-Source: AGHT+IG7X9ov+Kjt4xcWzka8j4byAJ8l+zRDjVgf1o65CanW/SsCf879lW3a9gyK1alwrR1qViax2w48g1Ky5FqBNmk=
X-Received: by 2002:a05:6358:c119:b0:1a6:82c6:a429 with SMTP id
 e5c5f4694b2df-1aade12cd65mr829097455d.31.1720774384104; Fri, 12 Jul 2024
 01:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB612946A115B182F4C81692EDB9A62@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB612946A115B182F4C81692EDB9A62@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 12 Jul 2024 16:52:52 +0800
Message-ID: <CAJhGHyAFn96n8vW4z_cmXLCd4p1HfxQBLR-u81m8HipWRVsJZg@mail.gmail.com>
Subject: Re: Regression on linux-next (next-20240709)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nikula, Jani" <jani.nikula@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Fri, Jul 12, 2024 at 1:42=E2=80=AFPM Borah, Chaitanya Kumar
> commit 1726a17135905e2d2773f18d47bd4e17dd26e1ed
> Author: Lai Jiangshan mailto:jiangshan.ljs@antgroup.com
> Date:   Thu Jul 4 11:49:13 2024 +0800
>
>     workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.
> `````````````````````````````````````````````````````````````````````````=
````````````````````````````````
>
> We could not revert the patch because of merge conflict but resetting to =
the parent of the commit seems to fix the issue
>
> Could you please check why the patch causes this regression and provide a=
 fix if necessary?


It has been fixed and it is in wq/for-6.11.

https://lore.kernel.org/lkml/ZpASNBN0hpTVcjE-@slm.duckdns.org/

Thanks
Lai

