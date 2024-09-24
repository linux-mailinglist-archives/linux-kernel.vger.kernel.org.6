Return-Path: <linux-kernel+bounces-337579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FF984BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CEE1C22C64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49592130AF6;
	Tue, 24 Sep 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gDIeMDP2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E5335C7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208118; cv=none; b=dJYetVLUaPKLB5RJSQ3jqo0pAApH1Pvxve4dm0z9Y9WWpL2/jyvdG6PEYGOqHpbFz4iIxKy/bxtRvzgRvkX1O0X7jnKiBlDkvx8cGDTzF5ba5iuwKgeLvpB+h3uQgNCLCLoqcoFvExt89eWXVhXr9MGggFztqSnrZJAnmK+4L2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208118; c=relaxed/simple;
	bh=WUWs1cGV8UAjwT4Z5LncZWgi8ievdMfXJpppyHQHoic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ur3tNESIugg1ZKns4CcIai2UQhyieN3KRlqzVc1TnJrOUko4+De5VzZNBPRuzeWmqaLhPYfm8doM9J/x4BY1KtIuvMzUtqJykSbF8uJe2dvbhepgH5CppcwOeHDSSUOEVFCg+L+rVVxg51X2f4+aq5V59/Ru0YGcGzRim+c2Tm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gDIeMDP2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53653682246so345329e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727208115; x=1727812915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RCAkYMz+z1YFzhY4Fh2dqrlaBUsgV20ERyXCfxSdKns=;
        b=gDIeMDP2zRPht7KWvmrz75gkmfCJbuA2e/eXqMBGxScju2PnB7CeFciKt7h3RyXYev
         9JlInlXCx1V6e8NXHVmcRMeI1w4k8LUuhgWukNHlltqrpIsR/rEmG1OxRuy1eptkwDtO
         p39cNrL3VN0HoonK+nCqfcYy9LgdDPm+ofnm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727208115; x=1727812915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCAkYMz+z1YFzhY4Fh2dqrlaBUsgV20ERyXCfxSdKns=;
        b=BH/3DnzGDvRkPZN4Ox2js8hfVoWIlDyzjnQKmQGBHBvO+IHyU8UK8sA40ITty8p+x2
         plpqKgtlwSRAjxC2rINR6dUHi3ScU5WUl51GYkjh+Ma/lXw6LGOINS0cZoI4SDhlqEjN
         7jVJfdZ/6g9MvhuAl0yqN2/SbbEcGObT+wRea437o6BP7O7zO6x1DJH3WDDOr7s3U7Ib
         u3KpmYvWNrijQBWDOWqGNFRfQmHjukBHlPUlY/z0WWf2LdIh6qthYu5rgw5Nd/TmwkR+
         l8/8McEw+Hu9SeSenAIr6f76L+nmQWOAxvjdlIe8YyoCMNFBui/k9mT4ec//pQ9lvFPK
         Ev3w==
X-Forwarded-Encrypted: i=1; AJvYcCWtS/eSjk0ONk3lR7nqxZlsdShg3oRgzPXtXes8n26H0jAkxrGWO2lZVDABlL5iMWBbpLJaaTM6GRpO3vU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SLwLwjKWH15vFfsj7BuH4dPVj6DoDqDF7kGB+0bq/x8IT+YU
	AmB/1AyNJ/qPLogT1Dbu1/9+/dhJQh1t6S1cKqn3O5l0y1Pw+zKkh8Kvyi9IykZKwj8UISCYrX+
	Vg0l/gA==
X-Google-Smtp-Source: AGHT+IHDZBMBB316t/pWrDj2r0RjFR8RScgXufQYyZpMB1H7x1zfAki5UGYip9H34/ihS/hW+Qd0hw==
X-Received: by 2002:a05:6512:3b92:b0:535:6a83:86f9 with SMTP id 2adb3069b0e04-538804c7028mr110277e87.60.1727208114814;
        Tue, 24 Sep 2024 13:01:54 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134b3esm123545466b.198.2024.09.24.13.01.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 13:01:53 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so840377866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:01:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZQhTvD+gFvO2xj+ll79pVgpuSJR3kDHTmiZxpFJ/FpgUn2JTNnQmTG0hgb0FwFLCNzFo187mChj53M2Y=@vger.kernel.org
X-Received: by 2002:a17:907:a0e:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a93a03af734mr34328766b.32.1727208113495; Tue, 24 Sep 2024
 13:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
In-Reply-To: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 13:01:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com>
Message-ID: <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com>
Subject: Re: [GIT PULL] [GIT PULL] cpupower fixes for Linux 6.12-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 13:19, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please send this up to Linus if at all possible before the merge
> window closes.

Bah, I took it directly, since it was in my mailbox and was lit up
like a christmas tree because it triggered my git pull search
criteria.

                     Linus

