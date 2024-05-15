Return-Path: <linux-kernel+bounces-180382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D68C6DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D10A1C2229B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C315B540;
	Wed, 15 May 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhqQmlAx"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1215B159
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808210; cv=none; b=fy26RC7p6gqE+1YurLcn4EyAroNkwrQurpSJcBoFSsQMl2h1EiMgxzLlo177FnKtCCK8qrnrT/A9pEEKSpPo4EO/j2kiMHMR31yimq5J1gkUFsgmaiBDZYzI3CgZqvsB4Hg3bfTk/uUv+ECalSAq+lk61+PjGRK/9TEpXr8t0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808210; c=relaxed/simple;
	bh=0bZrMTEzSJyGLU+1iaAm3gzS/iAMcqebq3Gza9P4igE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0cVclx/mLqU70JFXBvBBIM9DhOovoLZR1VetwEx2isZOwYE1r42nMbBH/8gnabhHOGFEJAymnSOytxrPrXrW2mzIeZKArYZ61FLjPwBEviacKNXvdzRH2VVi2moVkNqXovHwrLroR/tZeiK/3yUSsvPIW6CrcVqpsP0WVOdr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhqQmlAx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43dfe020675so2309951cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715808208; x=1716413008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD8+IMzeNqwu8PcRhXHvU51M3Wk2fj6yp4uWJzohC/s=;
        b=OhqQmlAxc3+5TUmPzxP4nXhwdHXgbKN84b1u65IULV3wION6tUb2GwG8qY9LCYlIS0
         9RhwtOn2ZGxReIE3KHFLzYfUE8XnFDTZRFG2BnDq4ECR+MZRJCTRrKAxoVVBPj1Fj575
         s674B+WOiqdv3JoQgoCIobo7Y5YzqLHppoKOv9yPwcC53O5BAU0uJe2LyFfQvgOjbeD/
         84THlWXPyZW8yswI7qCBr4pb3XpPjTv5rSERrQO/gQ1wXNMfi94SX75xg33Ge7K4Rh1G
         524SwIArKqEL6JQf77DQa+FkLerrp0JFF6XOQv62kk+DsfUzgXbjQKbrseQ1/pnb8NwO
         h6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715808208; x=1716413008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD8+IMzeNqwu8PcRhXHvU51M3Wk2fj6yp4uWJzohC/s=;
        b=FoSbqy3wnuqDZfLkrc6Fz/sp4G/N78b/qS7NBCAAP1AK6C+3SsO3u62co3Y3+33nyR
         Jh70eX3gm1qhhTVWHRFKU8gnYNkI+NZ/0SNqWbTpntT+njCxTZ5dyouGf1dErh9xoSRw
         MzcpHYfbJqeCvCHymmTkec2OpRSM0nlSsUbmfm3FBc+fg7KPXHbq22qUEVS9k8PCwvmO
         75UaGn2Z6Y+idwoLx3isNsVpw3KNnVvgM2f27g3cjYTdNJnHbiyLkH4PvtRvatgBMqez
         Fq29nPJkedOVnitKu0EuyxKQo5fV1DgsFHZkGa8C+NOOk0+iowWWjtZBoOklkt7go5gR
         cpHA==
X-Forwarded-Encrypted: i=1; AJvYcCXxhH2Af3KS4unG9dPWKBljtkNzj+noNhq97W7YaTIweXknhZzjBcvNrg8Ve2hdg1c5nHmRDMOBi8Wt3mOrxhXP7MTu9Qmm/EYwceey
X-Gm-Message-State: AOJu0YzmeVjvZ4JfjfepTxXhYWd16xTUW7gQ3NxnZ1vTEj7E3Df09v4A
	iS6Or2l/Ds7luyPb13yxjGc+95dnJFYy7WxsknC/ATg1nMwb2q1EtvF7Soy/b1rgrJDthsdT8k5
	17ylADuJLq4Z/gzXuQN0aLW+0psMvGxtZAciby17Qm1NPuKIWKxBo
X-Google-Smtp-Source: AGHT+IFue5emqn/LHFSNZRtEGFcdNSYph/nzud89n5KuMeGSGlxgBJoiiSYYM0QRBPNuiIt4RuBBVKxDfiozpMKM1TI=
X-Received: by 2002:a05:622a:4108:b0:43a:b51c:46ca with SMTP id
 d75a77b69052e-43e0a2ea43fmr16263881cf.29.1715808202330; Wed, 15 May 2024
 14:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515202915.16214-3-shresthprasad7@gmail.com>
In-Reply-To: <20240515202915.16214-3-shresthprasad7@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 15 May 2024 23:22:42 +0200
Message-ID: <CAGETcx9Bq2=4OiqZndWaW+ZVcDv5sXOEpd2YHzZ_SYBxKf54dw@mail.gmail.com>
Subject: Re: [PATCH][next] of: property: Remove calls to of_node_put
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
	julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:35=E2=80=AFPM Shresth Prasad
<shresthprasad7@gmail.com> wrote:
>
> Add __free cleanup handler to some variable initialisations, which
> ensures that the resource is freed as soon as the variable goes out of
> scope. Thus removing the need to manually free up the resource using
> of_node_put.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> I had submitted a similar patch a couple weeks ago addressing the same
> issue, but as it turns out I wasn't thorough enough and had left a couple
> instances.
>
> I hope this isn't too big an issue.

I didn't see the previous patch from a couple weeks ago, but this
patch looks good.

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

> ---
>  drivers/of/property.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 17b294e16c56..96a74f6a8d64 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -773,15 +773,14 @@ EXPORT_SYMBOL(of_graph_get_port_parent);
>  struct device_node *of_graph_get_remote_port_parent(
>                                const struct device_node *node)
>  {
> -       struct device_node *np, *pp;
> +       struct device_node *pp;
>
>         /* Get remote endpoint node. */
> -       np =3D of_graph_get_remote_endpoint(node);
> +       struct device_node *np __free(device_node) =3D
> +                           of_graph_get_remote_endpoint(node);
>
>         pp =3D of_graph_get_port_parent(np);
>
> -       of_node_put(np);
> -
>         return pp;
>  }
>  EXPORT_SYMBOL(of_graph_get_remote_port_parent);
> @@ -835,17 +834,18 @@ EXPORT_SYMBOL(of_graph_get_endpoint_count);
>  struct device_node *of_graph_get_remote_node(const struct device_node *n=
ode,
>                                              u32 port, u32 endpoint)
>  {
> -       struct device_node *endpoint_node, *remote;
> +       struct device_node *endpoint_node __free(device_node) =3D
> +                           of_graph_get_endpoint_by_regs(node, port, end=
point);
> +
> +       struct device_node *remote __free(device_node) =3D
> +                           of_graph_get_remote_port_parent(endpoint_node=
);
>
> -       endpoint_node =3D of_graph_get_endpoint_by_regs(node, port, endpo=
int);
>         if (!endpoint_node) {
>                 pr_debug("no valid endpoint (%d, %d) for node %pOF\n",
>                          port, endpoint, node);
>                 return NULL;
>         }
>
> -       remote =3D of_graph_get_remote_port_parent(endpoint_node);
> -       of_node_put(endpoint_node);
>         if (!remote) {
>                 pr_debug("no valid remote node\n");
>                 return NULL;
> @@ -853,7 +853,6 @@ struct device_node *of_graph_get_remote_node(const st=
ruct device_node *node,
>
>         if (!of_device_is_available(remote)) {
>                 pr_debug("not available for remote node\n");
> -               of_node_put(remote);
>                 return NULL;
>         }
>
> @@ -1064,19 +1063,15 @@ static void of_link_to_phandle(struct device_node=
 *con_np,
>                               struct device_node *sup_np,
>                               u8 flags)
>  {
> -       struct device_node *tmp_np =3D of_node_get(sup_np);
> +       struct device_node *tmp_np __free(device_node) =3D of_node_get(su=
p_np);
>
>         /* Check that sup_np and its ancestors are available. */
>         while (tmp_np) {
> -               if (of_fwnode_handle(tmp_np)->dev) {
> -                       of_node_put(tmp_np);
> +               if (of_fwnode_handle(tmp_np)->dev)
>                         break;
> -               }
>
> -               if (!of_device_is_available(tmp_np)) {
> -                       of_node_put(tmp_np);
> +               if (!of_device_is_available(tmp_np))
>                         return;
> -               }
>
>                 tmp_np =3D of_get_next_parent(tmp_np);
>         }
> --
> 2.45.1
>

