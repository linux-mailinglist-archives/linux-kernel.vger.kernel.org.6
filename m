Return-Path: <linux-kernel+bounces-421323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1829D899F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8660D284AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3701B3958;
	Mon, 25 Nov 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeXbfRzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB216291E;
	Mon, 25 Nov 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549582; cv=none; b=M5OoIskJHKyMBcRYbytG4Z0k7EDUgH+gQPfqoeqKGBOHK4w/YNwrGSfX9+QfFtxIBFKTuclFbllINQnQa65tBRmr4YYe5PSeUtGX5VI7nnMbVyS8V4UbKPgxkmGAlR+mdWUE9uJR8h0pqNWjfUcKprbaJnnpPLqkOVNVkAkGCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549582; c=relaxed/simple;
	bh=dWqz9RFJ1FBuVTDfQfATkz3kc1MiNoOOxO5kbvjsrmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWM278Cg/5Ea9N0rqvGFGxpCF1JZzPf9JcErk00m1Hs6n0LMuvSFcvvYer9yc0kvOM1gfrvUJH+MHFjKUhDVFJ4nZeGW19SPbLoV+cK1IxE/Nuu2RGdX5V1jem3eO+qIFx3txZRIcrV1WEXKIaMHPyYTUGhMLyY91yn6EOERUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeXbfRzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3478DC4AF09;
	Mon, 25 Nov 2024 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732549582;
	bh=dWqz9RFJ1FBuVTDfQfATkz3kc1MiNoOOxO5kbvjsrmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aeXbfRzxulmCryo5pQuixXxTOoHM22b7jLaJ6lCjz/2xLrMrD0SumRblMErmeymE3
	 gZZ5k0a7X64DSsjkIPIq/ezHC5UKdcUf3rwYvplhKxe8C+ydL9hms9cY40yk2bHRJw
	 w0l1U4xy+AM2dvl+KfQwZ0hf66ooI+Ylw4YaFbyl+/uaRFmyssaRxy7FuRGK/m5iX9
	 dk5Ni0zEJ5gF5Cu+dzO968unNfz9yUGyrhWSh9JxxYIJoO6rmGzZKNl4wbCRlG7O94
	 FJsY5sabhEvIn88vN3WOZdbxYG2MNQrKTofYs9fzY4SFWdr/8Zzre8Txg8FJ7oL1pr
	 4Nxmi0AfV8Lfg==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3884cd186aso4513427276.1;
        Mon, 25 Nov 2024 07:46:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjuyQTrNy/qp73Zrez0oNdZWW98Id3El1Ty+gge5/xxH8S/DFIGR727oA0238koMejlSgCvE6feo1qEtoD@vger.kernel.org, AJvYcCXW8kJrBzg0Dxr8ApQpOIPBsKQkebwBL2hWja0zZsefSomcK9WdhcQDAwJ6ouToepSpQ6i7GVmIaJ32@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6MqPCWd39wcn+x8ynl8yHL0gAkyAlnWSpRlQI00yiNVgbaUl
	3m0FSJmoA2Iks+2waFpDMLkj4kp9dG4H+AUzD0/FJyZuj0FCPpZtZx3KNUHiuZo2nUi2o15u9ys
	FGto/eTW1wgCYtUJzlOxMpR/vRA==
X-Google-Smtp-Source: AGHT+IEV3s+qT8XjK9WFDYlP0XGh1nqrPGJ0w33/rxXIERYLVMi0Ic+g1WwEtanEy9d5dnZGgSojV0Fm2l057iBsLR0=
X-Received: by 2002:a05:6902:72e:b0:e35:d8b1:571e with SMTP id
 3f1490d57ef6-e38f8b0a979mr10608748276.10.1732549581435; Mon, 25 Nov 2024
 07:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 25 Nov 2024 09:46:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6e28pZ9G55Ab6SJO_xNK1R7D-xReC8girvP9VMUk=2Q@mail.gmail.com>
Message-ID: <CAL_JsqL6e28pZ9G55Ab6SJO_xNK1R7D-xReC8girvP9VMUk=2Q@mail.gmail.com>
Subject: Re: [PATCH] of: Add Google Juniper to excluded default cells list
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 5:32=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Google Juniper platforms have a very old bootloader which populates
> /firmware node without proper address/size-cells leading to warnings:
>
>   Missing '#address-cells' in /firmware
>   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0x9=
0/0xf0
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0 #1 933ab9971ff4=
d5dc58cb378a96f64c7f72e3454d
>   Hardware name: Google juniper sku16 board (DT)
>   ...
>   Missing '#size-cells' in /firmware
>   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:133 of_bus_n_size_cells+0x9=
0/0xf0
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.=
0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
>   Tainted: [W]=3DWARN
>   Hardware name: Google juniper sku16 board (DT)
>
> The platform won't receive updated bootloader/firmware so add it to
> excluded platform list to silence the warning.

I'm interested to know what needs these in /firmware. /firmware is
supposed to be for things without an MMIO interface. An alternative
solution is to add the properties. That doesn't require
CONFIG_OF_DYNAMIC and is often the approach powerpc uses.

I'm also wondering if ranges is also missing?

Rob

