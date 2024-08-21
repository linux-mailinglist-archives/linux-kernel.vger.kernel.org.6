Return-Path: <linux-kernel+bounces-295912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6795A2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB4F28217E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB7D15886A;
	Wed, 21 Aug 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q+aKMcOj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513C14F9F3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258041; cv=none; b=B/CWi9k0q9sHLV3XlNis/cqMA9fabAZqPkG3mOuBRTMbFeCyJ1eUw6E59CVJArr8t4A/DV+xsjhGDxYjmsvXdyLmo4TwK9+BMCf69A1ypDMCf3mMJLifDJ6nW8E8luALdV2tSVVp74dfcoysxEhiq9n3Rj/MuAOb1qi5wTpSBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258041; c=relaxed/simple;
	bh=sVgg3XEZ8t6920CMtY3WUo0BXNqLQRfIMdIh/d8tUDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSru+0uY1fZeBdX5ezwr5uvs0ShmjTuqrwTItdk5J6Aj0E/6legEDmzuWO/GJYZtu7/LMQeaAc/c/6XaHVh9pWUeFPE+5q5VC2oWgEfAzLcsTWIDxjLO9fw4FnEYZoEqZAX649CYC9d9Y3IjfaBatBOximpOeYdY77X0CLBmDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Q+aKMcOj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a81bd549eso577559966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724258038; x=1724862838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sVgg3XEZ8t6920CMtY3WUo0BXNqLQRfIMdIh/d8tUDE=;
        b=Q+aKMcOj7olrk26tcg3l21UCz3percFAwRNW7qT+jaVcugvqCaDHsM/+SQDpE0Aw18
         O6a/mP2n6/YxwQtUx9mUa5K1uuJQ6RCVD2A+8IC5/ydxqLj/TqXVlSEVVxgDysaVu2YN
         iLVmiY5whRLIQX9nvi/+YMNy/wcxcsh4uuplw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258038; x=1724862838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVgg3XEZ8t6920CMtY3WUo0BXNqLQRfIMdIh/d8tUDE=;
        b=TDO6MS90Nuez+udsQRAlHgGJxX6pD5lrcUrWgOgyoBIAK9k2K6ks95w5kPniBdNtuC
         PQ/5eZV8r3glpi959kbQBddMnLHbcYkskFrrxawYTBTietio5pges4BQ7S5MumEYoOuz
         HohAEgADOp9yVYAn5GaTc24S2BarFhnzWo/agXrW0kLf20eJdp1OuhXRI6mKPv/cuHby
         BZu2ujpUUkcNJrbVcTn4XBpkn56oIJbgmydmSCRO86nQzLEuhAsi8Xfmh1HimgBVXIDm
         yTQOn3CE8mnYNe0uHL58gRFBSfrSFWopPslI0eWNMKByfvIOx90FLWsuPmyu0ij8pBy/
         h9mA==
X-Forwarded-Encrypted: i=1; AJvYcCXEHikXJwaD7L9FD9q/CrR2B5lOXvSKIeP8gWQQTmur44E7Da4LfL/R8csQ97sqclc+cS5ZCPRdPALyvh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmC/zJaR+O4u0eiI5npqOkAEmWVzC3u9Rh6rePGaox6hCnOKk
	PfTFK3JtjTuEKMo1pu/meCXABTukgk4JInaBYOfmBpqaKqYFpIzyKhfAfjWp3ZFJZlRNlTErqNT
	VSVDtHb0LYmAMAecphWQvrODM3cQyVjY9IXGMHw==
X-Google-Smtp-Source: AGHT+IGDayd7xuAjuOBPzNSKAAgetzBjuj+Vul4/WCcTjqLvTO4EBhzQwJUfxXdLsV7UiBI1uJ93BDSvM19wz5RFwBY=
X-Received: by 2002:a17:907:96a3:b0:a86:78ef:d4ad with SMTP id
 a640c23a62f3a-a8678efd649mr202521966b.20.1724258037501; Wed, 21 Aug 2024
 09:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-fuse-oob-error-fix-v1-1-9af04eeb4833@google.com>
In-Reply-To: <20240819-fuse-oob-error-fix-v1-1-9af04eeb4833@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 18:33:46 +0200
Message-ID: <CAJfpegtOnAfAzz9-OcnXqMvwDeAO5a_j356Zi9eoRH_viMOj4w@mail.gmail.com>
Subject: Re: [PATCH] fuse: use unsigned type for getxattr/listxattr size truncation
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 19:52, Jann Horn <jannh@google.com> wrote:
>
> The existing code uses min_t(ssize_t, outarg.size, XATTR_LIST_MAX) when
> parsing the FUSE daemon's response to a zero-length getxattr/listxattr
> request.
> On 32-bit kernels, where ssize_t and outarg.size are the same size, this is
> wrong: The min_t() will pass through any size values that are negative when
> interpreted as signed.
> fuse_listxattr() will then return this userspace-supplied negative value,
> which callers will treat as an error value.
>

Applied, thanks.

Miklos

