Return-Path: <linux-kernel+bounces-282898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08F94EA48
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345ED1F22209
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B616E88E;
	Mon, 12 Aug 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BDcYZW2J"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8516DEBD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456251; cv=none; b=MiFg9hljab79xuMojU3bIpJHArE/lCAKV7qm+AuaP3hNC7lY+gAAENMcHit/Mp7cn/OTzciZ95ebu/RSLdni4VA0qoNE9i/MEeDblOuXcHMgybLABCWHBilhq/65ioPtzGtRTDnYRTgrK0hBgwwlbUSOy/CfLCSLzzjrq5NYzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456251; c=relaxed/simple;
	bh=rFbhJ1kr9LbVJJHVCLKuVhtZqqyv3L8v38WNx4e/J0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm3rJJ+66ZByW3+ROw4fjU74ovDLlZsonDNyyByGDlkIEu0nrJd4ojsRWnXKe+AcWFEo0f+5reBH5SVuBzZRjOyjan74UyaE5JDvWZo23g1hlDA9mu7SwY5dKZQ7fuNhN4B9Bawz4VusYUUdheZr5rDiYsROTvaRVDqjNJ9yaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BDcYZW2J; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso4712005a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723456248; x=1724061048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rFbhJ1kr9LbVJJHVCLKuVhtZqqyv3L8v38WNx4e/J0A=;
        b=BDcYZW2Jmak9rg7x9duAnZOZ9I4/aoJmQcDSAeGynJNmnG7FNfKQxoJLBBjYO/jVck
         oFM+v8W0jRliMNWjvJkBri0THap7jL2aBqfx92kQ+ntKNsdNCjg+ezHWfIS6Y24t7H1y
         qrenIc76WqMe9WBCqFY08Eu0hpL9sZUTIj7y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723456248; x=1724061048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFbhJ1kr9LbVJJHVCLKuVhtZqqyv3L8v38WNx4e/J0A=;
        b=jz33sjDOVxqgnisx2Mk5lL/fnU8E0PVUAvHMfwvlMdBtv8fNpSEvqEmyIUCEq9xhRC
         0TzKp8EVul/SihIFovv3k9Onc+V0wQTK/IT8jox8eDrGYtQufnNMAt5fSD4v/GOcJPZQ
         5oyEp72fIQBqr/Hxh8T3kOiztaArZbB18ZLtD+KxbBIY0fYWwiDncA/a2jWnMR/2T4tp
         dHafCPppBnmQlJ9uR+fEPpxMjXa1XmAbVGi9WBxhrpOXUe9R8TIzFDVcrVgNEr37Flas
         L9JlmtKlG3X/Rg4JeVDF81tDnWmNCnXgLG6WUVp2j5QBU5kCj20iRCjCa10wtW3tjuu1
         Fh/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrUNi0OLDJbXaPW0q0CLbMYWg+weEix2iScoe4Wxr8rAj4nB8JL1eY5a4eoz9BY6kcgYkiK+agD+faH7CL5WZowiprj+MqI1kbMuqx
X-Gm-Message-State: AOJu0Yy+pM9Wo08BRwdGc06AcEwCWxkMv5Cgmpn7HcdXX37eDYc/Bdbp
	iI7+2/2fmskQCZWsVkPACe3Nc5FdytrW+aGbF3ZJ/syQDiMGJpnXRVg9DWrmqIZncxDG7gGdPhM
	=
X-Google-Smtp-Source: AGHT+IFDu9PMe3X56NgzUQfTzHsnu1YD1mVgvH8t1TFA5Hz8ZssFK8vuubqo4TO8sOdsel9zFmr6zQ==
X-Received: by 2002:a17:907:f786:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a80aa5993c9mr558204566b.24.1723456247666;
        Mon, 12 Aug 2024 02:50:47 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb23c250sm215046966b.189.2024.08.12.02.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:50:46 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so447227366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:50:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvKL+f5jTvSejL68zf45LU1X1ahpS31M/QegnW+uYQQittACO3pXIGjzusHRT1MqgTRmwDoADPCjI6WqBze4is1BTtBJyBbKubSIGy
X-Received: by 2002:a17:907:2d91:b0:a7a:9ca6:528 with SMTP id
 a640c23a62f3a-a80aa546a28mr622117566b.11.1723456245700; Mon, 12 Aug 2024
 02:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org> <4fsxowdpaeaxcnu7aewif6yqqk3jdgsjtksbznv2arnmmtiaq6@ibzf2qcel5lc>
In-Reply-To: <4fsxowdpaeaxcnu7aewif6yqqk3jdgsjtksbznv2arnmmtiaq6@ibzf2qcel5lc>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 12 Aug 2024 11:50:30 +0200
X-Gmail-Original-Message-ID: <CANiDSCtZWUx_RmZ8j3-x_LN_m76AzyrUUrUubCGt8kieLGvZfQ@mail.gmail.com>
Message-ID: <CANiDSCtZWUx_RmZ8j3-x_LN_m76AzyrUUrUubCGt8kieLGvZfQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] media: Fix the last set of coccinelle warnings
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, 19 Jun 2024 at 08:41, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, Jun 18, 2024 at 01:37:43PM GMT, Ricardo Ribalda wrote:
> > With this set we are done with all the cocci warning/errors.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Changes in v5: Thanks Vikash
> > - Remove patches already merged
> > - Fix typos and remove hfi_resource_ocmem_requirement
> > - Link to v4: https://lore.kernel.org/r/20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org
> >
>
> Just for the clarfification: does the driver build without errors
> if only a part of the patchset is applied? I have the feeling that first
> patches introduce a build error which is fixed in a later patch. If
> that's the case, it's a no-go.


I believe it should build without errors for every patch: It has
passed the bisectability test

https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/62071294


>
> --
> With best wishes
> Dmitry



--
Ricardo Ribalda

