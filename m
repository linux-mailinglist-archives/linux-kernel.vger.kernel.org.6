Return-Path: <linux-kernel+bounces-441662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE499ED20B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82CB1881E75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47851DDC14;
	Wed, 11 Dec 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scZu4i3D"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF791B6CF3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934852; cv=none; b=MiPM75oL9LACHXa1Ht7MOTcUiIDOf0NreExahRjVAFirDCPECvOJxCSQCIWUiYFwU/menXQuUGoEG5BFJRlKl3mFyoUp5nnhEApY7yOMEbkk097Unh9mkQyjV43UvAXzPJ0sVRpR2Wfc85duBkrpfXaUodDKzlOBB+s4T+Iohr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934852; c=relaxed/simple;
	bh=Wc3BI5a4DQVItmA1LcSv4S4TnOBWHfkmOeIWFty/edg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vn3LAbzm0JFOrgt/nvEpfsIWG4a8PmnAMc8glb6C23ehnsczk6fWi0yyzZQFzsD18dTYT/+Dd8Sn1m9rf3Iwkn3yrbPj2cBlerjGnw0DsWoLc5WkUjmNALb3YfSbN+QHPbmkUJ+4kij1OaTadLlFq0ep8bmuPKn1sIpl3oV1aHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=scZu4i3D; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso917123e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733934849; x=1734539649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc3BI5a4DQVItmA1LcSv4S4TnOBWHfkmOeIWFty/edg=;
        b=scZu4i3DPVPB3wBY/tJutMgP7deLbGvZ0rswMkCCFXmscvldO4/9v50Pc2M9um3CII
         XbhRRPY7Kaoje4WHSbNuNNGVOb+PGE41V+3HWIOcqYwPgamNmbUNLyQmBVfN10SF464Q
         yzj358EWqU4LHwBpoqmnoEItKZL4i807y5SWEB7eV7EY97rJQ54xidFU8q5xd200bI5I
         O24LWm1MCnpeOmLWS4lzxHVVXJpbr17E/BJ5p/EzgE8uTJOfvo45uT0gKO/CIRiF+OlR
         T7wOaWgjlhOA1J9VDaYapNzdRvmQYh+An1BTIYNyqx85iLomRLcDpwxH/H7geaWLFVCa
         noVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733934849; x=1734539649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc3BI5a4DQVItmA1LcSv4S4TnOBWHfkmOeIWFty/edg=;
        b=hsxjQphv8QbcN4QlTfxQXKr3OmI+sNMD78RCkypUdyEPoFDtKEFXhUFUwDMEp4GlLT
         RoOSYcoE4FWnlh6RC3KIVyT8r47cej0sfaSeHZW7pRFEhwexqhAg7mj0VFiXHQsYdg5K
         1fUDjqkWIs/yCxWxP1M4OIt7YW3Cmtwgtf50izYUmmYF3DFM5V+7kc3JS8TxsmfM40GD
         pGedsBnM+Pnh3cHUEMX/KXmgDbXDqq+JAgIjruBQFm1kjvmqBNn54DhQGkwHZu4r4n+j
         Kf/89n2y7sQakngi+H/FU8MjhMEawvGpc62HjsrSu+L21glWX2Mai3ZgKe+ZQhOl23te
         2N9A==
X-Forwarded-Encrypted: i=1; AJvYcCXyqw4UmwY/W63bFBd0D1R+svx0oc77H5dsTActbOyLvUcOLtZnBaUTrUmCq9Tc7Fjt/r0wqwaSQj5ckz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcnLfcRegkD7ALKlbcO8LSEF7DrtAdhEHCRvfSUsKPt//Fi6Z
	UYYzqd7JJzyjYXNTQUS+9Zabz5AYFVBRGWnsTy9Sn68+ATKiNz5UFp8JAkIN/LMAzHxetDW7EbR
	p09stf3bfZzKjRKMb+mcEdKHskhY2ieST8/dr
X-Gm-Gg: ASbGnct93F2UN0nmUUsu/C+CYpiW/PBr62rmP01nKUFbvO1T0SnqrByB1ZuGYF378P9
	xgofIsgMZD3i85cSCT2WL64kZa853kNLMe8I=
X-Google-Smtp-Source: AGHT+IGANx5FXJZ0PiAIVACiotPBnFNKQGAlWqPPmfYeR5t6CiEoR/ZaFnWrjiNlwU+8vBwKPyf1creuhLdpisW0A28=
X-Received: by 2002:a05:6512:68b:b0:540:1bd0:347a with SMTP id
 2adb3069b0e04-5402a783b95mr1192159e87.26.1733934848532; Wed, 11 Dec 2024
 08:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211001927.253161-1-linux@treblig.org>
In-Reply-To: <20241211001927.253161-1-linux@treblig.org>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Wed, 11 Dec 2024 08:33:56 -0800
Message-ID: <CA+f9V1OssWoK7gOSx8Vv4c=bVnFkWH-0kDLUay=DoWGEx8gEEA@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: Remove unused gve_adminq_set_mtu
To: linux@treblig.org
Cc: jeroendb@google.com, shailend@google.com, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:19=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The last use of gve_adminq_set_mtu() was removed by
> commit 37149e9374bf ("gve: Implement packet continuation for RX.")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>

