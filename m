Return-Path: <linux-kernel+bounces-347724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25DB98DD0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D69CB29892
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D921D1305;
	Wed,  2 Oct 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8YKaRd0"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE031D079C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880112; cv=none; b=a7mDX3jcDwQMY9kRS2MQLU+41U/6RyZjTidP+6sh+FidxT69lvylRzX24gpL1FGrImmlz8Yg2NgtpD11nORQInPcmb7D2H1glDQ9DZQjNA/AXWv1vtVWd9royNhxOUJAO7sCyDMToM8JLsxAfgEv1dMe6fFb7k6V1YT0urEQsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880112; c=relaxed/simple;
	bh=ulb3R5Wfk7/ubPSlaFlhZCU4V6Gp2LxB7njIRKnYloM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfpBU8LIA/AiBdwBqvoIv+9i8HZA1JGAfWTxEN4a44x/kGfYBFUQq18lDewwvb2v8ATx2oFfBiMuudbdc4sWMTrURZGcS66z1WWwyLVjw4OMi8Lw6lfxkz9YfJVILJ4W5HgEopyrdR7nFBU8yk1eB0psjqs2cs1S3xzjvZ/NA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8YKaRd0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso32920341fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727880109; x=1728484909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulb3R5Wfk7/ubPSlaFlhZCU4V6Gp2LxB7njIRKnYloM=;
        b=C8YKaRd0rRrrqyi0SSn37dBvCt6yL9iu6RR1XcZUD1wKiKXzeM39lvN8rhTFD1zOSQ
         tNkypuwf/kbtAfPIAEKnBoDkJO1Y+1c6sjan2/ibyPgHE4iPELiq0a/PscGyEvLMmYpS
         hF/kU9HkCW0/+gcZNstoqxls/qWMQkNm2S8P1sQekzNZInOlKa5qNXHRsuwzDW64aPD8
         baAZXb1WtUUnCXvovjhBcII/oaoPZY4GHz2BA5Sj6Sl3ANr6xQGZJGxKpFxq9/O+yESd
         cTypZcxqeH10wtFsKM4d3VjbbxMHNBn/BbQazL/9zn5x5xZWBS/JYLZRjZh8PqHXsBI7
         Bn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727880109; x=1728484909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulb3R5Wfk7/ubPSlaFlhZCU4V6Gp2LxB7njIRKnYloM=;
        b=d+s0lfaBIeV5p3dedoa9JVQb+Twj0a8kzUEcfjWMMXSs/EXyc68XsoOHx/zdam/rQQ
         DW+Nr0mCd1C6BlG15jEPQU9WeEON8UUQQP/R1wNIaKVj4rSCtKpAizsR3mSdQLnXHuYF
         zyp+JRiiHx7bxyyqt8T6b2OVsEUiPL8RLQbzW9ssyNMIjQsWNbfaO5PGgNoGWjfh9HhS
         DDSXi6+Gmdhk9t75D0a8WlgoX+xQ9jy2lGy+R8fHiBIugCpxTWI9os2MZkz72P5T7vZf
         y7nMUDYk6CLVX7/xNgq/XZsKzuMsrcJXb+2pHcLhi3cRCHGzK5HkpuOYJLeFQWVQ1TuT
         mO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9+LppxAjdmevXrspH2j3BXG1XGaY5xeyljqG5lJP1yOG3rEf0YQhXt992JgeMJ6zg6MJCdwHn8kBIzmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+bFUPhHD+RxUc717QDlACveTv146AXVcSxJEKbrnynh8TeSw
	UyCt2j61o7LxJKJ5soDDL9FDK096JjgaN6C4ZpJy5xL7PyTzIAadjYbhStQ5+ua2r+/UdrMnFhb
	48RZKFer3EeMlTquh+qkcr2eXkEHw7uDCyTQq
X-Google-Smtp-Source: AGHT+IGyuL2o/MknenVgF1lAABe9b/kTAQZt3zG2i1PYFGkUcadVLtLkBU77pk1O0Ev1wH7hXvbAkcQKVEkkB/IhGZs=
X-Received: by 2002:a2e:be13:0:b0:2fa:e4d0:eb61 with SMTP id
 38308e7fff4ca-2fae4d0edccmr13111291fa.32.1727880108666; Wed, 02 Oct 2024
 07:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001193352.151102-1-yyyynoom@gmail.com> <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
In-Reply-To: <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 16:41:34 +0200
Message-ID: <CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com>
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux@weissschuh.net, j.granados@samsung.com, judyhsiao@chromium.org, 
	James.Z.Li@dell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:47=E2=80=AFPM Moon Yeounsu <yyyynoom@gmail.com> wr=
ote:
>
> Moon is stupid. He doesn't understand what's going on. It makes me upset.
>
> https://lore.kernel.org/netdev/20240919145609.GF1571683@kernel.org/
>
> Simon did the best effort for him, but he didn't remember that.
>
> Please don't reply to this careless patch.
>
> Replies to me to remember all the maintainer's dedication and thoughtfuln=
ess and to take this to heart.
>
> Before I send the patch, I'll check it again and again. And fix the subje=
ct `net` to `net-next`.
>
> I'm very very disappointed to myself :(

LOCKDEP is more powerful than sparse, I would not bother with this at all.

