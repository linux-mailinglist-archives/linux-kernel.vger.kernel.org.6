Return-Path: <linux-kernel+bounces-433573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64609E59F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFEB285B14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CEA21CA0F;
	Thu,  5 Dec 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bRy0lif+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A34218E99
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413365; cv=none; b=KTTdayVYJC6bSAan0oqIRjD4cF/jDIMJhMSZZFMr7hJBaE9QQVwG9McEkC4jjpomJ09po5KZVNa/O4CmpnSVWsHf9nO7wwXXo/oeDPsLKrvNr1yGE/ubiS6bbBnf0l10zm18/RdfXMGFDlCps9O6eZqYGdnCdFYVr5aPX2kJox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413365; c=relaxed/simple;
	bh=QooC3WdeOAD0e0lYcAEtRhgjyLoS+4sHCp6vodx3A7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gd00aU7HYdgP3P1TeplETfPaySEjjNdb4/IegxVhyQpAP2LspKZt2KblFzCYgt5I0FteKjOR2zDsMKweGlms3a8rMScCVptyvO3RNhCgRlNNz5yugDGNut2PfLDt9pjVP8G7i9m30s/KItVw9mlDlzy3S5oE0hZ7+q0EWaTi5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bRy0lif+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so215426666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733413362; x=1734018162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QooC3WdeOAD0e0lYcAEtRhgjyLoS+4sHCp6vodx3A7s=;
        b=bRy0lif+SnNj2nq40HgFJekJuJU+SvFrX+Cy2J3Q00z9vUhCAWBo0Ja6jN3E9h28lN
         SkArcnss03+gQ5oH3ii89Plmsd0xNar+sOK7w3uL1FH/nHS6XSO/FPbTB7tnpJKh+Ghp
         rG8JkLiAhXbCXMIeh4Y/zlnK6MhpOla0e/mnEEnJ0Fi0mEwtUSAiXjWFu92/uBT3OiF6
         SehkBwdB3F6hbwFtDLFoqV9k6trUiWlHogzrGCzfXKqhu9PF4odTyICeg8/QfIFpXnXd
         q8KXvDR1blpVlw7EiicMKLLVP2odDO1TjQ8JEc/9cK+QnUFyoRIcpLl1cxiG0+47zExC
         f2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413362; x=1734018162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QooC3WdeOAD0e0lYcAEtRhgjyLoS+4sHCp6vodx3A7s=;
        b=Dkj5mukYympyzajZH5Dg2i52oNvqBr27r8To1lrZ0DSTZ+K1KJmk21EeuHJ6p2abR6
         uaSXkF2Me/+wI7yDAcWNqy75QXucUVDZzA4odOXIQ5hRCMsAXn/zUVDwfKULL8ETSVjK
         svMOUS1CXB7quIqm6BcsU+oMOJO2zBWS3phs6HCQLtGmv9BP/DQfDBxxZnHhSWZWz1R4
         UV/4lumZtSa0pfkmQMOrf465LJjafydNK4KSeoD3qC31/nkyWm1Fp8OcL3t3o2s/F8oS
         UUUz7RpEm51cnvcm/D0L8MqRutxNsg6vyOMvNOjpFRabDVH+tOa9xynB/iFIEeNSbWzl
         kZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/wHpuG/W8O4qvlD9juLWzIJ0lVFqx/wMex3mfzZtifv6R6gbAM6y4jT6FCJ1kJ0QcKXOxbqyrqk9TTSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hTds/81QQwZ175IwmJVHPHzWMd6c3vvseawfBxx80H9/cGuT
	2Rdb3+JzF+OzCeZVY4LxEUoucbHX0bABtxkl32o+GGt+TsDQUVyoVwfn7kC5kXqQ48kcGxSLOXT
	ysj9CdqVDRWpNYtvfpkRRQRv07fIq3FJmvsd3Jg==
X-Gm-Gg: ASbGncvsWXM3efWraCCbAKYR5ZQ5oSlHyKqw9Fp+Wl6U6Gi68ify7bYwRGdLW2SbNHL
	92PMAZ/c/iAYAH/aiw+XkLWHAOzjdRHAHS9/DEoF7cfLWFpTlsy+0rOj2BML2
X-Google-Smtp-Source: AGHT+IFRIZj39BqksGePaUik7a+kIHoLqLeLpwrOobFeFWewSYsxmbm4qW2oqzvnqze4KT6xrlgNWJQIXaK21ap6IUY=
X-Received: by 2002:a17:907:1c21:b0:a9e:b08f:867e with SMTP id
 a640c23a62f3a-aa62188ef0bmr348632966b.16.1733413361757; Thu, 05 Dec 2024
 07:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
 <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
 <CAKPOu+9K314xvSn0TbY-L0oJ3CviVo=K2-=yxGPTUNEcBh3mbQ@mail.gmail.com>
 <CAO8a2Sgjw4AuhEDT8_0w--gFOqTLT2ajTLwozwC+b5_Hm=478w@mail.gmail.com>
 <CAKPOu+-UaSsfdmJhTMEiudCWkDf8KU7pQz0rt1eNfeqS2ERvZw@mail.gmail.com>
 <CAOi1vP8PRbO3853M-MgMZfPOR+9TS1CrW5AGVP0s06u_=Xq3bg@mail.gmail.com> <CAKPOu+-CpzPaY28MH9Og=mZTYmu99MUFTs+ezDZvud0HVb9PAw@mail.gmail.com>
In-Reply-To: <CAKPOu+-CpzPaY28MH9Og=mZTYmu99MUFTs+ezDZvud0HVb9PAw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 16:42:30 +0100
Message-ID: <CAKPOu+9D4AozS0SPJEm0bNh8Y8WmQ-mYQeC39bMNefi8+KYErA@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:37=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> btw. Alex's patch
> (https://github.com/ceph/ceph-client/commit/2a802a906f9c89f8ae4)
> introduces another memory leak

Sorry, that was wrong. The "break" only exits the inner "while" loop.
I got confused by nested loops.

