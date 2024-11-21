Return-Path: <linux-kernel+bounces-416715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB49D4923
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF63A1F21716
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE61C8FB9;
	Thu, 21 Nov 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CT23zlq0"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B715573D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178782; cv=none; b=kCn+8v3icyZKbpaQG9azXTbySfCa/yvC6LSmbhMBvsKQzDzelO04i22iudoMM9n+jktXAQy5O1xz2UQe0z0dmUyB5SIcbtqLkfq5yU8/+QQIM1J61jbmx+fQm/6J//2tVINP0v74Q7z92dM3zemmFlGMVqClbuT/0BKizytM6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178782; c=relaxed/simple;
	bh=9qt1EpV1bysbJHfhnYNJdFDp5xfXTjrCsxoooow0Xfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1Py/ricaAFeGHNWWbU62mRWd6leCYY1O1nNuL/ZzvB1VOpREDhuae5O60JsKkq3y1vyD9Y22lmScD2elSgizOvIQm2kkvN0RKdS199bGDYqhb7UzX1/53nsVMm3nU2L0IuoRhYJAMSEobtXwwU+OiLdQAiNqAva7pyTs/eQMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CT23zlq0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc0209eadso79808a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732178778; x=1732783578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qt1EpV1bysbJHfhnYNJdFDp5xfXTjrCsxoooow0Xfs=;
        b=CT23zlq0sUeL3u+bpWjE7jcpKfhEu7rjAtkZ6AfcF5kVEUWniaj6YEIz4roRdN32n2
         Jw1qpJxPoDyr4rE6g3wg019XElcox/WfqVRWM1AWcg6bdjh80pAXL4CH5JZoJGIB9RUQ
         9gvXw9KoZpID4k9GOs1mWa6Oq5ChEHkgpPAzk//monTlz+NjR3ZxUq6UHbVDTeBjgBL8
         X6oStyC5GXay3wAGDUi90+nZewLxl1nndPM+iGBoGIlypylMqGGJpZVQdjbK5j507UaJ
         00CqfMuhKOj/g+VpvYqAASe/AIwc75sT/ys5itr/X+qSW9FRis6Js/BARimHVQu0of7z
         MXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178778; x=1732783578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qt1EpV1bysbJHfhnYNJdFDp5xfXTjrCsxoooow0Xfs=;
        b=oR2HGyTMvV+ecP1Htn0e+iYK4jBJkUOcmEPCZxLvxtrW6UMZo5qlkZp6xB84ID6fXa
         IXfYhvtv1GEhcgdRshVT22maHx/rkjBfpDlmo43du9o0X9j9DGPxTOE7lko47sUUHwzh
         8EWSMJ/qzf+rPfRmCKMnqmi0Pk7xNB4QtqcE6lHbVSq5ymb6PNECTu7nfnszYPSP8UOA
         BDhTTQeqPjvBH2MiVh4Tavooo1mUg11oBp6ozdgh35Dvf3qx79Rq66jf7pXv1IhuQ7E/
         +BiIrNOoHEs4gzlvYVFDJQjcpe3KQtLtdQMxW4Id/KY0+jvI0cs/UDV+ITDw/wIvJMTf
         Ou9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJoXvjvwHh6lpWWv/9C9W59u5W9TGvi4aSDQRE0o9sgEPeFpNlzyoTIgAvqPCffVtdPDm9zkr4Hu3a5J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0hV167PlcYhYutzs9Izml23syjB/R/xuTiGDhl57HQu3MKpL
	1RmqdJwnWnAoxXr+lpQ7ZkstXm3lTtAIqLiUzNgMDQ8zQvdCwU8dUWmLqth2N6hc/jvb3hDTKrX
	RqPAdHyuxDIhFVmd0iysvyyeCR6Ho0pJIH9fD5Q==
X-Gm-Gg: ASbGncsQCLbWm2xCWOxh7E5yo3jCJVXmuhgeL52QtkSFDdq6pt5Sj2qv/jZxPaaGDgG
	unQVbSa+9rANuQERY0MBmaG4aT/o36tc=
X-Google-Smtp-Source: AGHT+IGogOxhYP0i1TIV8N4U2jFv/3TwdSfcYGe1+KmvUFQgNDY+0i5crU2hWbGWyo3fjct6LbG5gQlZuypGj1x05pg=
X-Received: by 2002:a05:6402:5186:b0:5ce:fa24:fbaf with SMTP id
 4fb4d7f45d1cf-5cff4d04716mr1797534a12.9.1732178778547; Thu, 21 Nov 2024
 00:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adf796b9-2443-d29a-f4ac-fb9b8a657f93@huaweicloud.com>
 <20241119152939.158819-1-jinpu.wang@ionos.com> <CAMGffEkODwo19u0EjKojQ0WaWVkvOOB8aRR8R3NXn+oC6TFQWQ@mail.gmail.com>
 <d456368e-cff5-5476-238e-4cc97f016cfa@huaweicloud.com> <CAMGffE=hKeWTJzna8gFi=Q9wSuY9SLFScftdGVqc5MNW_jxQ4Q@mail.gmail.com>
 <19e59a67-35a8-164d-67e7-bc55508f4dd0@huaweicloud.com>
In-Reply-To: <19e59a67-35a8-164d-67e7-bc55508f4dd0@huaweicloud.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 21 Nov 2024 09:46:07 +0100
Message-ID: <CAMGffEkc_8=FkieQ6QfM9wHMBxaLOnoSzi_ujadKX-P3-UUKQA@mail.gmail.com>
Subject: Re: [PATCH md-6.13 4/5] md/raid5: implement pers->bitmap_sector()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Haris Iqbal <haris.iqbal@ionos.com>, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, song@kernel.org, xni@redhat.com, 
	yangerkun@huawei.com, yi.zhang@huawei.com, 
	=?UTF-8?Q?Florian=2DEwald_M=C3=BCller?= <florian-ewald.mueller@ionos.com>, 
	Christian Theune <ct@flyingcircus.io>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:44=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/11/21 16:40, Jinpu Wang =E5=86=99=E9=81=93:
> > Hi
> > On Thu, Nov 21, 2024 at 9:33=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2024/11/21 16:10, Jinpu Wang =E5=86=99=E9=81=93:
> >>> On Tue, Nov 19, 2024 at 4:29=E2=80=AFPM Jack Wang <jinpu.wang@ionos.c=
om> wrote:
> >>>>
> >>>> Hi Kuai,
> >>>>
> >>>> We will test on our side and report back.
> >>> Hi Kuai,
> >>>
> >>> Haris tested the new patchset, and it works fine.
> >>> Thanks for the work.
> >>
> >> Thanks for the test! And just to be sure, the BUG_ON() problem in the
> >> other thread is not triggered as well, right?
> > Yes, we tested the patchset on top of md/for-6.13 branch, no hang, no
> > BUG_ON, it was running fine
> >>
> >> +CC Christian
> >>
> >> Are you able to test this set for lastest kernel?
> > see above.
>
> Are you guys the same team with Christian? Because there is another
> thread that he reported the same problem.
No, we are not the same team with Christian, I guess he will test on his si=
de.
>
> Thanks,
> Kuai
>
> >>
> >> Thanks,
> >> Kuai
> > Thx!
> >>
> >>>>
> >>>> Yes, I meant patch5.
> >>>>
> >>>> Regards!
> >>>> Jinpu Wang @ IONOS
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>

