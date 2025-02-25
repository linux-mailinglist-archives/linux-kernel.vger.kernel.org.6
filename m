Return-Path: <linux-kernel+bounces-532589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B2A44F98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992EE3B0AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7992135CA;
	Tue, 25 Feb 2025 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HKHrvHIP"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD2212D83
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521675; cv=none; b=OrZms5VobR/5WJAtTwA9RQkvZYuKcXXpIDcoyPXUdGGmg19BVAQq4BvcAOaQJb9bmngFuwkCpdaljzsGjF0x0eJbjYTS9lCzUEz7VeoCeKTkb3I8WqgFlrY/SF0BEhKH/xwSlLmbRTHuDy6+JlGy0e6xMJyOBFTwdx8y/8rRcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521675; c=relaxed/simple;
	bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QswyQZPaTvb7QX6HH3IshlrjTBsM54qlXhKf/L9ljLVVkNKtIjwglyKEMKWNFmGfKtV2UDcdPqTgRIeHH3+cPE4ApuO0hqdJq3vgQiI/uwvY+8BKCIzOH/7sTLoP2tCl37bvRAu8qFkaC6TRGqkNUEZDaQQKBc0Ee7g8WR3WsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HKHrvHIP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f9625c0fccso54485157b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740521672; x=1741126472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
        b=HKHrvHIPGOs1LAPhaKGNVYAN4p1hSmui5H2x05WfT8rpf/+sxE5cNaJe4j4UPShABd
         QdglBIJRHJlmFTsh0oXtBBF8oK31iko2mj5XAMfkURIXlnHuNViYHY6r4rtcvAFOoCtI
         iKp00SFOYRRF4IrIH5cz9W1tHw+QlEtTRXMqgiMh24y1D7JKw+EngatYg/Lh+9uAIW+r
         B1jSUsbiiMY20xcsisZek9Fjju86noKydwlAvseGVqLwOeC4Pci7nwp+jLZt0Uf28mO8
         we5gSJFCqE0NJTVwC1+55Q/k4JgavG3yBljPZJ2worsbEqjsdGQPxVIwT4TwA5Y2IM+5
         ukpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521672; x=1741126472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
        b=jBF3aB0Mvw7HJdRoXdQ+20Gi5x0jQUruE9SNSHxaiLK17AK0R8AGDT9oDC5m+sERH+
         GJ+rWnb5RTpy6PV49PWA3YZzMfyUoDMFSs8h443LX+TdqDqdmmcpk9hTviUn8Q+kuiix
         au1ayDAepVXoZmn+BiUBZriR6xLpne45VjXqR8ojiIkYYFsiXah2nc0W/uhSOtMSxVMe
         hctdgtHP+RGJQxWG161qkJz0h2WjFL45ijMxze6vGbuo3t2Zl7q/lwFroWyOCmgSuMbL
         zmTUG0wRjVCrT9axM+991Dpu7pGxueTVidtzxcKSeXsoh2IHbIp/8IXNHJTveQXzy2Up
         C8XA==
X-Forwarded-Encrypted: i=1; AJvYcCVS+oNafIUSy4L4P1RjkIad+uC0r9FX/64UFREEeOXc4v4r2gU1FR2eWW9d220vWwecUt+4N/zkdZNaHEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjP6u6PeQdtt5w4+C5J+DdJedzeH3w3cpkJfx77eI5PkiZ2wwt
	VGDKa8iWdLPxEDZfay+F879OxUV0Vs6lobZb8L9XM9csA8h0Fo3cho9zls9J0XqLQApf93NsSN2
	Jc8MbxSZ243H/8MQM1ZubGSgrZ7A2HMEFDtKA
X-Gm-Gg: ASbGncvFiDVEe9Mzi6GKlypdQiFHIr/Nn11JfzMU+cojRj9TFrqR5qTwHg7MEbrRA5K
	6OzjhYodv/p6+k2U2IOHYEHWzt5KlOc+K325sQ4wwdtoBtWdO1GccJgOOQnp1b6nZCizV0edoEZ
	2oef/KjNs=
X-Google-Smtp-Source: AGHT+IEq+q/3SNBzxXflir8s+6QdmuMLr7mPJKzm7/BUu7IXjxCgJ1uEovP+G+hSJ9QqgINvHv7u8FQo9Dm4e0gAv10=
X-Received: by 2002:a05:690c:312:b0:6fb:9fb2:5840 with SMTP id
 00721157ae682-6fd10ad8d15mr47580827b3.28.1740521672571; Tue, 25 Feb 2025
 14:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhxQfFfrpmRS6tOv5ANVug6d8dGx6Hsc7MYYe63sUOpcg@mail.gmail.com>
 <20250225192644.1410948-1-paullawrence@google.com>
In-Reply-To: <20250225192644.1410948-1-paullawrence@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Feb 2025 17:14:18 -0500
X-Gm-Features: AQ5f1JqI7MeM_scLLuLOFY1u27DXLEkWvnLakhLURvGM4cGQ0eQrhjUWTYnMN4E
Message-ID: <CAHC9VhSu-034tguAKj+rptYB0w8D9mtgmjbDgLwVc-bJQcSrBg@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To: amir73il@gmail.com
Cc: corbet@lwn.net, dvander@google.com, ebiederm@xmission.com, 
	john.stultz@linaro.org, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	luca.boccassi@microsoft.com, miklos@szeredi.hu, paulmoore@microsoft.com, 
	rdunlap@infradead.org, salyzyn@android.com, sds@tycho.nsa.gov, 
	selinux@vger.kernel.org, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:26=E2=80=AFPM Paul Lawrence <paullawrence@google.=
com> wrote:
> Would a patch to set credentials during remount be
> of interest?

Amir mentioned (in a html email so I'm not sure it will go through the
lists, I haven't seen it yet) that Christian recently proposed an
override_creds option using the new mount API, does anyone have a lore
link they could share?

--=20
paul-moore.com

