Return-Path: <linux-kernel+bounces-234395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC691C616
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159C11C22162
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FDF50A8F;
	Fri, 28 Jun 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgA3vrk1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964F4D8C5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600620; cv=none; b=YW9YkM7hS7SeJuW26mZWGGB1Ehss4sZ6iJ9DNKCZK3SJMvsauVoGenDhcyo2ZxtazntaVoQ0VtGRR3SfRqhjmnOMKfh5paRQkaiYInoEjExU9RSpcJv+ScfVqtYPRFwdFiOazLzfYH+h5bEqD8rUZHZNHJrTyTaHL1hX5+epwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600620; c=relaxed/simple;
	bh=O9Im7C0b3C4adLpd6iBlek+WA4C2wJk0bna3KFnoeYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHtbaLsTbUOjDk79xgFuII42nRj5qNapPlAxAA6kJWZ7QiS7zZ4CfqU48YRYRRG7WoJf7vDqaRweSqHx4a/bRctK12ifNG7zMT3I21Z90voomkz+ZCh3BGxMMFxnPg4UEgi/z2BiJrHh/Nyg9GbIstfVqMtqVe9aGtKFDW5bBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgA3vrk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719600617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9Im7C0b3C4adLpd6iBlek+WA4C2wJk0bna3KFnoeYU=;
	b=ZgA3vrk13SNV8ehvmUbDzTXwTyQ2jbOnW9meYnRlN7oJwoMsgzQK/Z9HRjtgt8kWc1jbBs
	PQhDf8jGbQOHWPgQtTGPynhGFNFAHu6nPrgyxr5S8rBe4JUsbxxa7sVWW1mWQAnUACzjFd
	6wQPwTnHhNmT4Li62DUaaYXgKYXwgjc=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-1rfpYnpDMwOC6eQ27BwJ9Q-1; Fri, 28 Jun 2024 14:50:16 -0400
X-MC-Unique: 1rfpYnpDMwOC6eQ27BwJ9Q-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-48f79297073so440210137.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719600616; x=1720205416;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9Im7C0b3C4adLpd6iBlek+WA4C2wJk0bna3KFnoeYU=;
        b=pOYbzRsWpal9+Shkb3Q+kk5I1XC1x70kLB8stwfLOUUWfsK7JOZCZtSk6BQ+W1KfO5
         q/FTm5c51D1pRgxY7mBLyipetErhLoxPss3Y0aUwrByqk7lpfnhpk2BUsn4AhR+6c7tl
         eF9r8fACAIeK7yj8XZTwVtUmjQ+OnCRmKm4hGFjS7xheanNClZ1DWp8d5pDDtahdlrcH
         y8oxJtc8xCr+NWbGMozN9P+fI4IOLwsaXJtVFUcSwJsD1Oeqmz6tiPqdAAtcnKgZ8tl7
         hUjnDvLenAP5AALMrhLnk4nGWSDfIe4OJ281oLV+tNQCLavaCo2T6lME7fdO6gCaKG2V
         AElA==
X-Forwarded-Encrypted: i=1; AJvYcCXvl2FHlQdLkdyRNc7to5j+O8ZjRVSkYyBh5mxgGUty1lD8Sy+U5WcpYOLb9QhSLGG9W7KjP3AbucjNQuik3wrPJK63Y44tDYzSUTtV
X-Gm-Message-State: AOJu0YxiT3ahiK/kLEbxkC4IbJs9DZlWE9vCzbxzS8vuixKAeSutlR+0
	kLha31e0GsRHxqQ6rNMo+gjVLenRkWkPI92YfoZnRQXS5JoKxWDtnazg+OY/NNhIaHOg8XReOnP
	Om20+oqiwNWi71u7Ko9knsok/2AR1qIXvNoXU8BrEUQ8ouHR5RaV65LNaHaJM3w==
X-Received: by 2002:a67:ff12:0:b0:48b:a44b:c935 with SMTP id ada2fe7eead31-48f4f136bc9mr16622136137.33.1719600615814;
        Fri, 28 Jun 2024 11:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElvRmmINNGnNs7Wpa+F7s40QSKueqKBDp+NCHe0hsGIwjIG9K8A2Un/dqoNkhQbEKVTVc0/g==
X-Received: by 2002:a67:ff12:0:b0:48b:a44b:c935 with SMTP id ada2fe7eead31-48f4f136bc9mr16622116137.33.1719600615434;
        Fri, 28 Jun 2024 11:50:15 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69308142sm96504585a.117.2024.06.28.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:50:15 -0700 (PDT)
Message-ID: <eab9d109981bae8a443649bc4a2c1a08870590c7.camel@redhat.com>
Subject: Re: [v3] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
From: Lyude Paul <lyude@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, Danilo
 Krummrich <dakr@redhat.com>, Dave Airlie <airlied@redhat.com>, Karol Herbst
 <kherbst@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, David
 Airlie <airlied@gmail.com>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
Date: Fri, 28 Jun 2024 14:50:13 -0400
In-Reply-To: <a91bbb5f-8980-420b-b465-97691203347e@web.de>
References: <20240627074204.3023776-1-make24@iscas.ac.cn>
	 <d0bef439-5e1d-4ce0-9a24-da74ddc29755@web.de>
	 <790dbe8aee621b58ec0ef8d029106cb1c1830a31.camel@redhat.com>
	 <a91bbb5f-8980-420b-b465-97691203347e@web.de>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-28 at 20:42 +0200, Markus Elfring wrote:
> > (...I doubt I'll get a response from Markus,
>=20
> Why?

Because the responses you have been given read like a bot, and numerous
actual contributors and kernel maintainers like myself and Greg have
asked you to stop leaving messages like this and you continue sending
them. I promise you, maintainers are more then capable of being able to
tell a contributor when they need to improve the summary they've
provided in a git commit.

>=20
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but I certainly want
> > to
> > make sure they are a bot
>=20
> Can I ever adjust your views into more desirable directions
> (as it occasionally happened with other contributors)?

No, because you're not contributing anything of value to the discussion
- you are just confusing new contributors despite having been told
explicitly to stop.

>=20
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 and not an actual person before removing
> > them
>=20
> I hope still that affected development discussions can become
> more constructive again.
>=20
> Regards,
> Markus
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


