Return-Path: <linux-kernel+bounces-418155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5669D5DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A13284D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAF1DE89E;
	Fri, 22 Nov 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYMU/eP/"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5D1DE4D7;
	Fri, 22 Nov 2024 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273900; cv=none; b=iQJbotDwrwGUX/M26fr9GPpPKA8WmcVJMLwqs1hpkDDu+0zwyQlEhAWMk9jo1YqeZfJtAQ2KTwJc8WAi3EmoXWSTnAJOnUSo2gcLWUhMnYPOp4FJlkeJj0Njh6DSbs/4piZvrcRGs+9q8dlZ0sRy8oMZNBRb/iurvat+dNkZUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273900; c=relaxed/simple;
	bh=fKWYclILh0wkSLIEU8fm6Nlhcn8x+7x+Cw0m2YcfETs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l+MOBzDLKSPM0Ov3cer0uP29NsMx1LZjQC1Vvf/lS0W+oocnCnK6VoZ3Z5gakU9KMTBY8n35JC55MuYxkYN6r2CkONtbB58CrqHuixEaOvW6FhhIn9lnmm6ygtgN+0SdzaPqIXXvtBpZTxIRL29LzO+WQ36XukTTLqPlIuMYSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYMU/eP/; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so1612146a91.0;
        Fri, 22 Nov 2024 03:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732273898; x=1732878698; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKWYclILh0wkSLIEU8fm6Nlhcn8x+7x+Cw0m2YcfETs=;
        b=dYMU/eP/Zk20TA+kktxOmKdHB2lrd2MgNUHmid3nw7qvfzAG3zVW/MhQa6QXFankX8
         ijtOKJzM+qLcgkQRPd9LLi3TZq82YLHQpjzKfwqjnN0rugNOZcYBD1Y88sykMA6ESw8u
         W8wAaOKprhhGwpzKlDBd0YCzk/5YMuaFKd98BnWVEnAdugCYL3EsVHLRl41uly0eL8sJ
         pW8LS+uteTOVr9i4okhX5WT6XJUDyw53eXfaFoJnEn5Zc1BroqBwFlBjQ6paF5xL2Vpq
         ZSzTX7hk8KsTUXydIg95QrsZLEm0C0UXxjigw9YQs51gLl5MWOefMZPjsJb1sNGJZSyI
         g9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273898; x=1732878698;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKWYclILh0wkSLIEU8fm6Nlhcn8x+7x+Cw0m2YcfETs=;
        b=hePJwMT15uh87lTwb+k0/SFbqPodd8el77f0qz2oq9K/NlgZs6gXxkNEpbuy70W3gQ
         dRop2fiIJ/g0frs/+fS6Lzr2cAiGVvsREv1Gg9cKrjPB8Y8s1+ZLw9o89+FHnIHDoPzo
         Iy0OnV+k/ZODuoa0Y+84aqE2raeWlF5SiUoPUNszyZgFILZATiPtXE/IIQTHzs8JufXh
         wr90hw5eSGZfAVlc5tEFJNiOXYL8VvEemfr7NmGVt6PRVpODN7xiPOMiwB+kPn8WYaO1
         bndxBcP/kRczpiBsLet/3aBZmJyy+/rTpkM2ghxw/OLSW5LOkJ/4dYALF0/CY9OIMRGB
         HPxg==
X-Forwarded-Encrypted: i=1; AJvYcCWHc0wI+/7J8dUmZnHmRKLhJ8yZepJurPs/TMz9MYiQHaTid0Buw3jUX2BJID1pkIx4T4h61EBI8Z8X@vger.kernel.org, AJvYcCXXSRwWz+vQ+udv9jTi75kX7INB39pnnsV0DEKxUzvnnXlnNJpPXwhi93zmoYJsOyMb+DcTH7lYTBp4niw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQGbyFETqYaH7VA9Od9AwHyjh6xkxR8AIUc0uJgklMsjrAvi8
	bBLyJVdb9jHuPeNshUJDoIju2iDAuB21P6hosFuudBMnivhvfyqJv47jXzLyaVeyhU0FHEzTgR6
	Os6NBuWeAeplWOB7sQT8Ol2DUAnQ=
X-Gm-Gg: ASbGncvCY3IeH7DrvI77nq3lSKcxfIbQVoMfMVNX7vFVh4fZi1/YybMRNuEHFGpQyDo
	oM67Oa0r8gfNLOqUdTK04nRlg47w7Hq7C62V4qnMNU5yq5nboxscrWbF8ckgW0/hcsA==
X-Google-Smtp-Source: AGHT+IGrw2+xfBA1kjbh7z6dht/O0os9kgfdQk02F4KZ/qfGreNH57Zu0nFZWB7JpykHNZP/Es/mRXKjZfbIYC5iR1k=
X-Received: by 2002:a17:90b:17c8:b0:2ea:8e42:c46 with SMTP id
 98e67ed59e1d1-2eb0d50eb9dmr2993228a91.0.1732273898534; Fri, 22 Nov 2024
 03:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oliver <thirphattt05@gmail.com>
Date: Fri, 22 Nov 2024 18:11:33 +0700
Message-ID: <CAC+OJWBpyQuTy-XzTeLDOZto_hZ=28sVVPjhMiM3Om3Q96bUNg@mail.gmail.com>
Subject: =?UTF-8?B?4Lii4Li04LiZ4LiU4Li14LmD4Lir4LmJ4Lia4Lij4Li04LiB4Liy4Lij4Liq4Li04LiZ?=
	=?UTF-8?B?4LmA4LiK4Li34LmI4Lit4LiY4Li44Lij4LiB4Li04LiIIFNNRQ==?=
To: info@wuerth.co.th, linux-kernel-owner@kernel.org, 
	linux-kernel@archiver.kernel.org, majordomo@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

4Liq4Liz4Lir4Lij4Lix4Lia4Lic4Li54LmJ4Lib4Lij4Liw4LiB4Lit4Lia4LiB4Liy4Lij4LiX
4Li44LiB4Lib4Lij4Liw4LmA4Lig4LiX4LiX4Li14LmI4LiI4LiU4LiX4Liw4LmA4Lia4Li14Lii
4LiZDQrinIUg4Lit4LiZ4Li44Lih4Lix4LiV4Li04Lin4LiH4LmA4LiH4Li04LiZIOC4quC4ueC4
h+C4quC4uOC4lCA1IOC4peC5ieC4suC4meC4muC4suC4lw0K4pyFIOC4reC4meC4uOC4oeC4seC4
leC4tOC4nOC5iOC4suC4meC4o+C4seC4muC5gOC4h+C4tOC4meC4l+C4seC4meC4l+C4tQ0K4pyF
IOC4peC4lOC5gOC4h+C4tOC4meC4leC5ieC4mS3guKXguJTguJTguK3guIHguYDguJrguLXguYng
uKINCuKchSDguYTguKHguYjguJXguYnguK3guIfguKHguLXguJrguLjguITguITguKXguITguYng
uLPguJvguKPguLDguIHguLHguJkNCuKchSDguJzguYjguLLguJnguIHguLLguKPguK3guJnguLjg
uKHguLHguJXguLTguKPguLHguJrguYDguIfguLTguJnguJfguLHguJnguJfguLUNCvCfkY3wn4+7
IOC4n+C4o+C4tSAhIOC4peC4h+C4nuC4t+C5ieC4meC4l+C4teC5iOC4m+C4o+C4sOC5gOC4oeC4
tOC4meC4q+C4meC5ieC4suC4h+C4suC4meC4nuC4o+C5ieC4reC4oeC4l+C4s+C4quC4seC4jeC4
jeC4si4NCuKclO+4jyDguYTguKHguYjguYPguIrguYjguKHguLTguIjguInguLLguIrguLXguJ4g
4LmE4Lih4LmI4Lih4Li14LiB4Liy4Lij4LmC4Lit4LiZ4LmA4LiH4Li04LiZ4LiB4LmI4Lit4LiZ
4LiX4Li44LiB4LiB4Lij4LiT4Li1DQrguKrguJnguYPguIjguJXguLTguJTguJXguYjguK0gOuKY
ju+4jyAwNjItNjY5Nzg3OSDguJzguLnguYnguIjguLHguJTguIHguLLguKMNCg==

