Return-Path: <linux-kernel+bounces-370882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3089A3337
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C1AB237AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B1155744;
	Fri, 18 Oct 2024 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h5ZXNB2C"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DFA3BB22
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220996; cv=none; b=bs7939d2AIEB1Q2CYgo+TNXufNF1DGdrJCdBWmldeJy23l+/2gIfOlDCjyjUv4uLZVhZwIkJyhfOsc9PsXV+kUZMyNpXurgwJLzlrNjE3mQGA7kccLb0UdfYRj72og4O1Z9th6312leDjZ1gb6ZMz4qcwh/RpVVwkRmJgWN0+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220996; c=relaxed/simple;
	bh=x+w2dV3IKJtSogsjI4c/SC6Wjws16B5FPOIXEfdyRBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQoL24yiNVOpaJJfNwJRS4hUilZ8NB3LpexO1fOh9UKtNQoIrJyjCXPW2FWy1gH+xztFTOuw1YTPMIiohdRRiseLlxA3UnZRtCzT1MyPbj+ej/6waszUWxUIn/spHSEX3e8cbDYr5NVVehbphhNoB8Oc+eVveBeOGD3eCchx38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h5ZXNB2C; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so1838453e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729220992; x=1729825792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8BoM82MQH39AyLd5pw7xTpHKtd6h9cczn0N+Ti+x+4=;
        b=h5ZXNB2Ci8fo25C3RBYPWRLj5P7X3cPOCHQK89tc/lhepFjMImzZoAMYJNLZX+hGeN
         h/PBvU1NjyX//gQ4anGE0PX5KF2NUuNIe+IT6mOyQiHa5NqW1GOS5TTQbNIEOrQ0mLZp
         XFQoTLELkRlz/5yGe2JbBHzj9kFNkTUYTujXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220992; x=1729825792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8BoM82MQH39AyLd5pw7xTpHKtd6h9cczn0N+Ti+x+4=;
        b=lbrygBmuljRxdiNpFM0m2MG7dey07ueKjbluyPCokuTkp79aqDLTAgBRAScgw49GOH
         IoooqEJThHCNsKIwMjfSKcBVahYOiqg1h/Oo7+GqVeqTxdRxd57y3UzI/wwUtF1h8CWt
         L6sd0huR06OFKjqjHH3oMjMX31i+a1keIXZLfjnzFovLQIcVezlrlmpr5ce3c2xlsYVs
         jZyF/XdcCqin9ncm1K+Aqhxtl/N2VVEY/h3UxczTu001KjhEVULcUWqvD+JKN0tauBV6
         WpTM4iKm6bgaFT/05HY0YeKranKlpAf3nE15OsqgE6KfwW1aJWp7wuIn0RRQwAtxK8aH
         1/ag==
X-Forwarded-Encrypted: i=1; AJvYcCWE5ovhHAH97OvNuufuLWIe+puJjYQPBUBzXtGBU1uNQ2Csfa+1jM6wQ6UJu1T/PIh2c5TWKNldmJdl+C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBx0YmzqmEpvMZFtbEhwftzhlWi0gS/OaMz810SOuiRjgmM1OS
	V8/xIVASFvKqRoVLQWkr9lx1aUUsND52GKgZGPRFsxA+lK/BC7rfemM28nBglo/aMOauiQUIt7M
	v5kEKhkidbbwMqqAtv5FsTNfjT5hIUdoZ6Hum
X-Google-Smtp-Source: AGHT+IGPr3HtC201mGuJFaELzY2BgG1/oI6ua9m4PItdxomarDyX79CpmKIUzsqRyWrJbDZmiCv7A3Y6gAjzbTexeo4=
X-Received: by 2002:a05:6512:4020:b0:539:8a9a:4e56 with SMTP id
 2adb3069b0e04-53a1545c412mr352212e87.53.1729220992400; Thu, 17 Oct 2024
 20:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017084244.1654907-1-lcherian@marvell.com> <20241017084244.1654907-3-lcherian@marvell.com>
In-Reply-To: <20241017084244.1654907-3-lcherian@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 18 Oct 2024 08:39:40 +0530
Message-ID: <CAH-L+nMRhE4c-Q43+LXFq_MNU7qzBdysTP=Smd3GXtbyJQoPBQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] octeontx2-af: Knobs for NPC default rule counters
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gakula@marvell.com, hkelam@marvell.com, 
	sbhatta@marvell.com, jerinj@marvell.com, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000041fcd0624b7a3a7"

--000000000000041fcd0624b7a3a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:14=E2=80=AFPM Linu Cherian <lcherian@marvell.com>=
 wrote:
>
> Add devlink knobs to enable/disable counters on NPC
> default rule entries.
>
> Sample command to enable default rule counters:
> devlink dev param set <dev> name npc_def_rule_cntr value true cmode runti=
me
>
> Sample command to read the counter:
> cat /sys/kernel/debug/cn10k/npc/mcam_rules
>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v2:
> Moved out the refactoring into separate patch.
>
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
>  .../marvell/octeontx2/af/rvu_devlink.c        | 32 +++++++++++++
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 45 +++++++++++++++++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/ne=
t/ethernet/marvell/octeontx2/af/rvu.h
> index d92a5f47a476..e8c6a6fe9bd5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -525,6 +525,7 @@ struct rvu {
>         struct mutex            alias_lock; /* Serialize bar2 alias acces=
s */
>         int                     vfs; /* Number of VFs attached to RVU */
>         u16                     vf_devid; /* VF devices id */
> +       bool                    def_rule_cntr_en;
>         int                     nix_blkaddr[MAX_NIX_BLKS];
>
>         /* Mbox */
> @@ -989,6 +990,7 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_=
mcam *mcam,
>  void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>                          int blkaddr, u16 src, struct mcam_entry *entry,
>                          u8 *intf, u8 *ena);
> +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
>  bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
>  bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
>  u32  rvu_cgx_get_fifolen(struct rvu *rvu);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/dr=
ivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 7498ab429963..9c26e19a860b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> @@ -1238,6 +1238,7 @@ enum rvu_af_dl_param_id {
>         RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
>         RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
>         RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
> +       RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
>         RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
>  };
>
> @@ -1358,6 +1359,32 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_va=
lidate(struct devlink *devlink
>         return 0;
>  }
>
> +static int rvu_af_dl_npc_def_rule_cntr_get(struct devlink *devlink, u32 =
id,
> +                                          struct devlink_param_gset_ctx =
*ctx)
> +{
> +       struct rvu_devlink *rvu_dl =3D devlink_priv(devlink);
> +       struct rvu *rvu =3D rvu_dl->rvu;
> +
> +       ctx->val.vbool =3D rvu->def_rule_cntr_en;
> +
> +       return 0;
> +}
> +
> +static int rvu_af_dl_npc_def_rule_cntr_set(struct devlink *devlink, u32 =
id,
> +                                          struct devlink_param_gset_ctx =
*ctx,
> +                                          struct netlink_ext_ack *extack=
)
> +{
> +       struct rvu_devlink *rvu_dl =3D devlink_priv(devlink);
> +       struct rvu *rvu =3D rvu_dl->rvu;
> +       int err;
> +
> +       err =3D npc_config_cntr_default_entries(rvu, ctx->val.vbool);
> +       if (!err)
> +               rvu->def_rule_cntr_en =3D ctx->val.vbool;
> +
> +       return err;
> +}
> +
>  static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
>                                    struct devlink_param_gset_ctx *ctx)
>  {
> @@ -1444,6 +1471,11 @@ static const struct devlink_param rvu_af_dl_params=
[] =3D {
>                              rvu_af_dl_npc_mcam_high_zone_percent_get,
>                              rvu_af_dl_npc_mcam_high_zone_percent_set,
>                              rvu_af_dl_npc_mcam_high_zone_percent_validat=
e),
> +       DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_EN=
ABLE,
> +                            "npc_def_rule_cntr", DEVLINK_PARAM_TYPE_BOOL=
,
> +                            BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +                            rvu_af_dl_npc_def_rule_cntr_get,
> +                            rvu_af_dl_npc_def_rule_cntr_set, NULL),
>         DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
>                              "nix_maxlf", DEVLINK_PARAM_TYPE_U16,
>                              BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index c4ef1e83cc46..9e39c3149a4f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -2691,6 +2691,51 @@ void npc_mcam_rsrcs_reserve(struct rvu *rvu, int b=
lkaddr, int entry_idx)
>         npc_mcam_set_bit(mcam, entry_idx);
>  }
>
> +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable)
> +{
> +       struct npc_install_flow_rsp rsp =3D { 0 };
> +       struct npc_mcam *mcam =3D &rvu->hw->mcam;
[Kalesh] Maintain RCT order for variable declarartion
> +       struct rvu_npc_mcam_rule *rule;
> +       int blkaddr;
> +
> +       blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +       if (blkaddr < 0)
> +               return -EINVAL;
> +
> +       mutex_lock(&mcam->lock);
> +       list_for_each_entry(rule, &mcam->mcam_rules, list) {
> +               if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, rule->entr=
y))
> +                       continue;
> +               if (!rule->default_rule)
> +                       continue;
> +               if (enable && !rule->has_cntr) { /* Alloc and map new cou=
nter */
> +                       __rvu_mcam_add_counter_to_rule(rvu, rule->owner,
> +                                                      rule, &rsp);
> +                       if (rsp.counter < 0) {
> +                               dev_err(rvu->dev, "%s: Err to allocate cn=
tr for default rule (err=3D%d)\n",
> +                                       __func__, rsp.counter);
> +                               break;
> +                       }
> +                       npc_map_mcam_entry_and_cntr(rvu, mcam, blkaddr,
> +                                                   rule->entry, rsp.coun=
ter);
> +               }
> +
> +               if (enable && rule->has_cntr) /* Reset counter before use=
 */ {
> +                       rvu_write64(rvu, blkaddr,
> +                                   NPC_AF_MATCH_STATX(rule->cntr), 0x0);
> +                       continue;
> +               }
> +
> +               if (!enable && rule->has_cntr) /* Free and unmap counter =
*/ {
> +                       __rvu_mcam_remove_counter_from_rule(rvu, rule->ow=
ner,
> +                                                           rule);
> +               }
> +       }
> +       mutex_unlock(&mcam->lock);
> +
> +       return 0;
> +}
> +
>  int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
>                                           struct npc_mcam_alloc_entry_req=
 *req,
>                                           struct npc_mcam_alloc_entry_rsp=
 *rsp)
> --
> 2.34.1
>
>


--=20
Regards,
Kalesh A P

--000000000000041fcd0624b7a3a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEICyFtQAz15XOiMMfOwM7gkNy2wkDs58s8jovUacHidgOMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAxODAzMDk1MlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBeqb19jgsu
t2egc9eu8kxRLfif39GpNpklxP687qLTn1brNXxIkNL3HeKGR4hn6XrS/KDB654/d7akILR0aDs0
XsW9jWqcHizlr82ywdjUzqlqL52Qh6XHyOGvuQ8AIGEAIzWJK/0FoyWRfejblNo/B3QkUhU11FW9
ukD+V4ftLN5m7gswq0mXCoAzEgLE0CUY3ba1VUlp40ECymOKyzvuDqLEv+514GqMt03yZEr07yIY
CPRvbrboJmtCwE5lFdeyW/5S6BScDfwC3av3qk1GMqDA6aW9Fn/IwmfF/0yZCu4k/q8nwtn6VZgq
YrdgBMXo2VF1ip1vufP7SPBvzrq5
--000000000000041fcd0624b7a3a7--

