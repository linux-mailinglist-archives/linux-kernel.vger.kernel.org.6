Return-Path: <linux-kernel+bounces-215268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4E9909073
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E601C24617
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77017E47D;
	Fri, 14 Jun 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYBtm24e"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD471465AA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382857; cv=none; b=TYfeKmrms/+cv7u1FTsFiTVmq81YZ9CLzJVTgp1rOaUIY250XP+aAKQRQpCxQZFscIH18Ao2EUlKcGaTn3T3pJvXCljrLgfjdge9lJXKLvDciTkNWPl/xh/XzyNPJCMP8WlYIdNH1TEsRXsHM+9H2gVSz86yzWXDbY9icNzNPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382857; c=relaxed/simple;
	bh=0nEb3gSfbpNCQF05a2LHM3iK60Zt11N7GPw8rCKzca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZn1AqoB5YKVdJiSNaqh0XpIZqBagU8wCGZszGBp/SWexcTqxm3B69BF3F+U+MlSB0R3ZPRFsVtEojRsToB2g1aR25WWlWxBSMr4V58Yl79KEyQeNzpq+Uu82IyBYVBIKD7xg3EfTfUMXWGEM7wEpklpnN7KIPWnqVdT2G7RLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dYBtm24e; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso12885911fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718382854; x=1718987654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsvUggwl2iaq+7ID95/kPZJoKFES9T3PhHRwe3ICtG8=;
        b=dYBtm24egFiBj0gwws5FWLCaNWd7UtbuWBrunGND0YKQZXWDOOTrym7iqQyckKwjJr
         Kse4W5zUV9b7VweGY/BQA+vIxNzaeKVnE6V9YHDDYf+vgRS/1t4YakziDHwqNmJF2zwY
         zDBcHFCTkJksu1+No9el17BfQFkGeEW07QFHR6yPew+Ema2ucWCVocpfY37NZ/wDhx09
         U9BA+82G4HAEADtVQEbysfgOse3DqAgPJXzZvXx9iQ1kChEuBFJLLvBauSi+mm0T9zWT
         I4jO8iZeFH71Lc9326yDnRK5QwKudpb9X7xTLlwjOtCEkFUeRIDA/ntm8fDmkdpdBTrl
         2Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382854; x=1718987654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsvUggwl2iaq+7ID95/kPZJoKFES9T3PhHRwe3ICtG8=;
        b=pc1omqKY85zucfwTMUnvMlw38Cfo6nJ0A0x3cRADX17cqz8M983xcBoDSOgE7W79sJ
         EekKWAhscIgjl4vmQgQtWiuUoZ67cTJAUEZAuho7kfSGDEB5EzNQ05MF8Uj1Xh/o4k1u
         b5esRAYmS4v+BiOlXMXRjLQ/Oqg4mEaCbsC6DfyWVJcA45pRinw7sGgr8lfvgckx8FPV
         1ZxBhRRKMz6B2hu8AslTODcEZ64g6RiJvDIGo8BcMukk9oIzP3lqRREs81dnLuPRiAK1
         WUgyjs873iYT+n4DkJLWEvrfjalH/enqocU3B9NFUwcRMxSnarN0cxS+qsS8wSxeEwUL
         FolA==
X-Forwarded-Encrypted: i=1; AJvYcCXS8y78kLn/PU+EhpIA6sSBk/w1WUPVfbCZV+g3uNbu4+c3z6O+82Yp2e0gPHPOKuOO/b5dag2Ih/+bOmkNkxcLNG0WjD6j4bszcU/1
X-Gm-Message-State: AOJu0YzqsaUXBcUEDorFqUv/L5yJ08AzRqlqP6wH3bHIWTdKWb4SrnLW
	kAYZVL2qwTOfDeTCex97G5Ve2NCvIoHH9PB79tMTK8pYIZgLhgPgb2XcNoq/H2w=
X-Google-Smtp-Source: AGHT+IGWO/+8GdkVi0zVWi4kRTQ+VAxP+yfG1FPOfEgKx9zHhcN/3noH2wJkYSc+zOPvMmPFAKBvSA==
X-Received: by 2002:a2e:2281:0:b0:2ec:ff6:3bcc with SMTP id 38308e7fff4ca-2ec0ff64128mr16860701fa.5.1718382854165;
        Fri, 14 Jun 2024 09:34:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c061d3sm5763841fa.50.2024.06.14.09.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:34:13 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:34:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: display: panel: Add compatible for
 kingdisplay-kd101ne3
Message-ID: <plucbf66gjhmt7bmtalqiopunqxnfjxljbt5flvjy3ssntx2vr@ou2pnejbvpg2>
References: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240614145510.22965-3-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614145510.22965-3-lvzhaoxiong@huaqin.corp-partner.google.com>

On Fri, Jun 14, 2024 at 10:55:08PM GMT, Zhaoxiong Lv wrote:
> The kingdisplay-kd101ne3 is a 10.1" WXGA TFT-LCD panel with
> jadard-jd9365da controller. Hence, we add a new compatible
> with panel specific config.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Chage since V3:
> 
> - 1. Abandon the V2 patch and add kingdisplay kd101ne3-40ti binding to 
> -    jadard,jd9365da-h3.yaml again.
> 
> V2:https://lore.kernel.org/all/20240601084528.22502-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> Chage since V2:
> 
> -  Drop some properties that have already been defined in panel-common.
> -  The header file 'dt-bindings/gpio/gpio.h' is not used, delete it
> 
> V1: https://lore.kernel.org/all/20240418081548.12160-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> ---
>  .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
> index 41eb7fbf7715..6138d853a15b 100644
> --- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
> @@ -19,6 +19,7 @@ properties:
>            - chongzhou,cz101b4001
>            - radxa,display-10hd-ad001
>            - radxa,display-8hd-ad002
> +          - kingdisplay,kd101ne3-40ti

I think the list was sorted. Please keep it this way.

>        - const: jadard,jd9365da-h3
>  
>    reg: true
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

