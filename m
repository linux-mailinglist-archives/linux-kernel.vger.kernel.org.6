Return-Path: <linux-kernel+bounces-274961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D81947ECA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167CD1F22C08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663415B102;
	Mon,  5 Aug 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZCiF+qsC"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CF14901F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873390; cv=none; b=tccB4Da0KYAfGuCO5fR30pkYlwdsrzJqcLFmYuTLW2bOLY75i9FUBdYQDDu6U/sRB3flEk7wgGYktAPPHq42BlctO3A3OtR2OQYvTxJ+yTNc9m+I249GRVya01bfdk0xC8nMRkeULFneZzY8bMSFeSzgI6GaWEzGZCrutShlSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873390; c=relaxed/simple;
	bh=GhxCvF/bdB7ARkocogWvdOYN1EHnCsxdnqmhWsHwq2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOC3TROHHjowxfNJE0VjX0HFlOzxVkO0LMVKWTYaJ73Wk3k1oKtVvMNWl7eHcxD7qNFMzt/k+8aB6EaK8KcibdUCQGLVWlQ85ytsXzB4CUEVENj9UcJ5eBhYaSqw+UPkFGe2WTYcG2VVGlWUQtk/3z04KFr3vk+x6GoEZssVPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZCiF+qsC; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70940c9657dso5959122a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722873386; x=1723478186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhxCvF/bdB7ARkocogWvdOYN1EHnCsxdnqmhWsHwq2A=;
        b=ZCiF+qsCqxRMLED2+T/E8xIycEHjFUQY2Q3m2a5umDH3Q0EM7DnAcURZVX4jlu6hPZ
         W/pkfZAa3o74oB6JEL1rmKm5GmJtCTTJ8qEdo+l0ctjyMt5TS5BRG2DP6gK7SEI5Lc3t
         Ol6DeWRpdfNc3mB2K4US9uYEivmrfQ0Huv4jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722873386; x=1723478186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhxCvF/bdB7ARkocogWvdOYN1EHnCsxdnqmhWsHwq2A=;
        b=TNT7F7ruu/wNIzASXfPLHpIiz8TxhmJuynA9SRVQxKI9mpLzHzj4bRzP0iPYsQrwqK
         +ST/AVNxyVASfd/drdDLvkPJOQVlXLG0SeGUjMFGtvTYDPObSsPr3EBQwq3REjkENyip
         WV6Zguh62Kwmxozo4uqap9/sMcrdBz+udMq5oj7MmjIpJa+fywlyMpQbM93Daf3+0xrl
         knJT1m/3WLcEXFgvLZtuU6k/MmlAZLFjLgp0XBuuWQ5K8q/++ZAqm+M7T0vAnDH6LqY7
         igAC7MwbZsCrtJW1aFJquw4AdB4bPjnuLmL1Jvvnf9ZcgcqTW0SBu6VWK4FptYh48LB8
         eerw==
X-Forwarded-Encrypted: i=1; AJvYcCXpUwL/1uSE0X7xiBFTCmk44gzmzGU8LBITXSzBEJvjYq5k7O157RCiVJKaUPDDDO86yXbBr0WFTCz1+GhjStMqm/Q2MuynH4lEFWSu
X-Gm-Message-State: AOJu0YzOBVgHM2EMJt5DrKKfcQQ7oiyn7RvHMknq6qdwh27y5c4Cfzk/
	mCl6x/c2xGbiNcbcHh4TMI51agJt4TNKnBYVM7Bw+v0qShF/XKA0oI9Y1c+RjoadAaWVfK65XdY
	=
X-Google-Smtp-Source: AGHT+IFYLylEnUs7HgFkwRztgnXZX3CW9Wuh8s9M6ggvR8yX3WBha3fiS6TVinF0bCifc9PjKnG1VQ==
X-Received: by 2002:a05:6358:6483:b0:1ad:14ec:9ff7 with SMTP id e5c5f4694b2df-1af3ba7cc5bmr1513806755d.16.1722873385792;
        Mon, 05 Aug 2024 08:56:25 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c864c87sm36828206d6.115.2024.08.05.08.56.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:56:25 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4518d9fa2f4so852791cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:56:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOOmYaplHpgVq7q5COYHLpjP+4yzyy9+A9GEmWkwnh/CNxIxkh4YOaYzicDOhlfT4kKnCWhUqBI3tSQpyYaNAj86w9DPbtD2EFajck
X-Received: by 2002:a05:622a:13cc:b0:447:eeb1:3d2 with SMTP id
 d75a77b69052e-4519b760378mr4844061cf.27.1722873384362; Mon, 05 Aug 2024
 08:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <gq5fcttutomphgfrwrtloqzczia3uc5qpont3lrowocan2xjc5@ubfabhsh3mfl>
 <CA+6=WdQuFYbADjG0i_zWMGYmw95H1U_McqCw4CLW0+Gate50YA@mail.gmail.com>
 <CAA8EJppoj1Y2675UOp=JH=-HLdYuuzfr2Sxy1zzkvLosmrRQNw@mail.gmail.com> <CA+6=WdQ6q=Zmji8KxCPYK17pFY4UAUBOykd5Tx4N_RZ1MfgOdg@mail.gmail.com>
In-Reply-To: <CA+6=WdQ6q=Zmji8KxCPYK17pFY4UAUBOykd5Tx4N_RZ1MfgOdg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 08:56:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V+bKW7aeD9hSkSE=pAOUpGyvhGqLhLmL6_z=+iBU8Urw@mail.gmail.com>
Message-ID: <CAD=FV=V+bKW7aeD9hSkSE=pAOUpGyvhGqLhLmL6_z=+iBU8Urw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel: jd9365da: Move the sending location of
 the 11/29 command
To: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, hsinyi@google.com, airlied@gmail.com, 
	daniel@ffwll.ch, jagan@edgeble.ai, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 4, 2024 at 7:38=E2=80=AFPM zhaoxiong lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> Hi all
>
> Do you have any other suggestions for this patch?
> Looking forward to your reply, thank you

Please make sure not to "top post". Folks on the mailing lists
generally frown on this and it's a good way to get your email ignored
by some people.

At this point I think folks are waiting for you to post the next
version addressing comments. Specifically, things you'd want to change
for the next version:

* In the commit message (and subject), "refer to the commands with
their names" (Jani)

* In the commit message, address Dmitry's concern. In other words, say
something about the fact that this doesn't cause garbage being
displayed on the panel during startup and why not.


When sending v2, don't forget to include Jessica's "Ack" on patch #2.

